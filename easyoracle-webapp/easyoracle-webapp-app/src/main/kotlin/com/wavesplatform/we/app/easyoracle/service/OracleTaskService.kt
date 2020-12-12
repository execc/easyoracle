package com.wavesplatform.we.app.easyoracle.service

import com.wavesplatform.we.app.easyoracle.domain.OracleTask
import com.wavesplatform.we.app.easyoracle.repositories.OracleTaskRepository
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class OracleTaskService(
    private val oracleTaskRepository: OracleTaskRepository
) {

    private val log = LoggerFactory.getLogger(OracleTaskService::class.java)

    @Transactional
    fun createTask(oracleTask: OracleTask) {
        log.info("[NEW_TASK] Creating new task for def ${oracleTask.definition.id}")
        try {
            oracleTaskRepository.saveAndFlush(oracleTask)
            log.info("[TASK_CREATED] Successfully created new task for def ${oracleTask.definition.id}")
        } catch (e: Exception) {
            log.info("[TASK_EXISTS] Already created task for def ${oracleTask.definition.id}")
        }
    }
}
