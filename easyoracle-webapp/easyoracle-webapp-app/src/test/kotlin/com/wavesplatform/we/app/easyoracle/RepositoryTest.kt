package com.wavesplatform.we.app.easyoracle

import com.wavesplatform.we.app.easyoracle.domain.OracleData
import com.wavesplatform.we.app.easyoracle.domain.OracleDefinition
import com.wavesplatform.we.app.easyoracle.domain.OracleTask
import com.wavesplatform.we.app.easyoracle.domain.OracleTaskStatus.IN_PROCESS
import com.wavesplatform.we.app.easyoracle.repositories.OracleDefinitionRepository
import com.wavesplatform.we.app.easyoracle.repositories.OracleTaskRepository
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired


class RepositoryTest: AbstractIntegrationTest() {

    @Autowired
    lateinit var oracleDefinitionRepository: OracleDefinitionRepository

    @Autowired
    lateinit var oracleTaskRepository: OracleTaskRepository

    @Test
    fun testReadsAndWrites() {
        val definition = OracleDefinition(
                dataSourceType = "url",
                dataSourceExpression = "some exprt",
                dataTransformationScript = "some script",
                signatures = 2,
                windowSize = 1,
                trigger = "some trigger",
                contractId = ""
        )
        oracleDefinitionRepository.saveAndFlush(definition)

        val task = OracleTask(
            definition = definition,
            data =  setOf(OracleData(
                    result = "",
                    publicKey = "MY_PUBLIC_KEY",
                    signature = ""
            ))
        )
        oracleTaskRepository.saveAndFlush(task)

        val list = oracleTaskRepository.findByStatusAndDataPublicKey(IN_PROCESS, "MY_PUBLIC_KEY")
        Assertions.assertTrue(list.size == 1)
    }
}