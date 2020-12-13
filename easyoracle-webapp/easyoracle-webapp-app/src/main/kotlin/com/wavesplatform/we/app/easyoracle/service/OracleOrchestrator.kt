package com.wavesplatform.we.app.easyoracle.service

import com.fasterxml.jackson.databind.JsonNode
import com.fasterxml.jackson.databind.ObjectMapper
import com.wavesplatform.we.app.easyoracle.contract.OracleData
import com.wavesplatform.we.app.easyoracle.domain.OracleTask
import com.wavesplatform.we.app.easyoracle.domain.OracleTaskStatus.COMPLETED
import com.wavesplatform.we.app.easyoracle.domain.OracleTaskStatus.IN_PROCESS
import com.wavesplatform.we.app.easyoracle.repositories.OracleDefinitionRepository
import com.wavesplatform.we.app.easyoracle.repositories.OracleTaskRepository
import com.wavesplatform.we.app.easyoracle.repositories.findMyTasks
import java.util.concurrent.Executors
import java.util.concurrent.ScheduledFuture
import javax.annotation.PostConstruct
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.scheduling.TaskScheduler
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.scheduling.support.CronTrigger
import org.springframework.stereotype.Service

@Service
class OracleOrchestrator(
    private val easyOracleContractService: EasyOracleContractService,
    private val oracleEvaluationService: OracleEvaluationService,
    private val oracleTaskRepository: OracleTaskRepository,
    private val oracleDefinitionRepository: OracleDefinitionRepository,
    private val oracleTaskService: OracleTaskService,
    private val taskExecutor: TaskScheduler,
    private val cryptoService: CryptoService,
    private val objectMapper: ObjectMapper,
    @Value("\${easyoracle-app.public-key}")
    private val publicKey: String
) {

    private val log = LoggerFactory.getLogger(OracleOrchestrator::class.java)

    private val executor = Executors.newScheduledThreadPool(1)

    private val tasks = mutableMapOf<String, ScheduledFuture<*>?>()

    @Scheduled(fixedDelay = 10000)
    @PostConstruct
    fun init() {
        oracleDefinitionRepository.findAll().forEach {
            if (!tasks.keys.contains(it.id)) {
                log.info("Adding cron trigger for def: ${it.id}")
                val future = taskExecutor.schedule(Runnable {
                    // Check if definition still present
                    //
                    if (!oracleDefinitionRepository.findById(it.id).isPresent) {
                        log.info("Definition ${it.id} removed, cancelling task creation")
                        cancel(it.id)
                    } else {
                        // Create task to execute this job. If task creation fails - do not worry,
                        // It just means another oracle have already created this task
                        //
                        log.info("Creating task for def (cron): ${it.id}")
                        oracleTaskService.createTask(
                                OracleTask(
                                        definition = it,
                                        data = setOf()
                                )
                        )
                    }
                }, CronTrigger(it.trigger))
                tasks[it.id] = future
            }
        }
    }

    private fun cancel(id: String) {
        tasks[id]?.cancel(false)
    }

    @Scheduled(fixedDelay = 300)
    fun eval() {
        val tasksToRun = oracleTaskRepository.findMyTasks(IN_PROCESS, publicKey)
        tasksToRun.forEach { task ->
            log.info("Executing task: ${task.id}")
            val result = task.definition.dataSources.filter {
                it.selector.contains(publicKey)
            }.map { oracleEvaluationService.eval(it)
            }.map {
                com.wavesplatform.we.app.easyoracle.domain.OracleData(
                        result = it,
                        publicKey = publicKey,
                        signature = cryptoService.sign(it)
                )
            }
            log.info("Evaluated ${task.definition.dataSources.size} data sources for task ${task.id}")
            val updated = task.copy(
                    data = task.data + result
            )
            val afterUpdate = oracleTaskRepository.saveAndFlush(updated)
            log.info("Saving updated result ${task.id}")
            val signatures = updated.data.map { it.publicKey }.size
            if (signatures >= task.definition.signatures) {
                val txId = easyOracleContractService.accept(task.definition.contractId, task.id, updated.data.map {
                    OracleData(
                            publicKey = it.publicKey,
                            data = objectMapper.readValue(it.result, JsonNode::class.java),
                            signature = it.signature
                    )
                })
                log.info("Send result to contract for ${task.id} in tx $txId")

                val completed = afterUpdate.copy(status = COMPLETED)
                oracleTaskRepository.saveAndFlush(completed)

                log.info("Mark task completed ${task.id}")
            }
        }
    }
}
