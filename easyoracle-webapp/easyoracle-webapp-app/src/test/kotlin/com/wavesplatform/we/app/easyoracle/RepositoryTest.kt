package com.wavesplatform.we.app.easyoracle

import com.wavesplatform.we.app.easyoracle.domain.OracleData
import com.wavesplatform.we.app.easyoracle.domain.OracleDataSource
import com.wavesplatform.we.app.easyoracle.domain.OracleDefinition
import com.wavesplatform.we.app.easyoracle.domain.OracleTask
import com.wavesplatform.we.app.easyoracle.domain.OracleTaskStatus.IN_PROCESS
import com.wavesplatform.we.app.easyoracle.repositories.OracleDefinitionRepository
import com.wavesplatform.we.app.easyoracle.repositories.OracleTaskRepository
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired

class RepositoryTest : AbstractIntegrationTest() {

    @Autowired
    lateinit var oracleDefinitionRepository: OracleDefinitionRepository

    @Autowired
    lateinit var oracleTaskRepository: OracleTaskRepository

    @Test
    fun testReadsAndWrites() {
        val definition = OracleDefinition(
                dataSources = listOf(
                        OracleDataSource(
                                dataSourceType = "url",
                                dataSourceExpression = "some exprt",
                                dataTransformationScript = "some script",
                                selector = setOf("MY_PUBLIC_KEY", "MY_PUBLIC_KEY2")
                        )
                ),
                signatures = 2,
                windowSize = 1,
                trigger = "some trigger",
                contractId = "",
                contractName = "TEST"
        )
        oracleDefinitionRepository.saveAndFlush(definition)

        val task = OracleTask(
            definition = definition,
            data = setOf(OracleData(
                    result = "",
                    publicKey = "MY_PUBLIC_KEY",
                    signature = ""
            ))
        )
        oracleTaskRepository.saveAndFlush(task)

        val list = oracleTaskRepository.findMyTasks(IN_PROCESS, "MY_PUBLIC_KEY")
        Assertions.assertTrue(list.isEmpty())

        val list2 = oracleTaskRepository.findMyTasks(IN_PROCESS, "MY_PUBLIC_KEY2")
        Assertions.assertTrue(list2.isNotEmpty())

        val list3 = oracleTaskRepository.findMyTasks(IN_PROCESS, "MY_PUBLIC_KEY3")
        Assertions.assertTrue(list3.isEmpty())
    }
}
