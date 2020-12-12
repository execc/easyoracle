package com.wavesplatform.we.app.easyoracle

import com.wavesplatform.we.app.easyoracle.contract.Oracle
import com.wavesplatform.we.app.easyoracle.domain.OracleDefinition
import com.wavesplatform.we.app.easyoracle.service.OracleService
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import java.util.UUID

class OracleServiceTest: AbstractIntegrationTest() {

    @Autowired
    lateinit var oracleService: OracleService

    @Test
    fun testCreateOracle() {
        val txId = oracleService.createOracle(
                oracles = listOf(
                        Oracle("3QVUnXdCq7vMJDjfcuM7G5qCqFKeBQuac8P", ""),
                        Oracle("3Qbur18V2vQfJEcnkqM3H9ieNozVup4mG2v", ""),
                        Oracle("3QZdm3KxwX4GRdrdGLxeZ4xmEyrv5rEXCqF", "")
                ),
                definition = OracleDefinition(
                        contractName = "it-${UUID.randomUUID()}",
                        dataSources = listOf(),
                        signatures = 2,
                        windowSize = 1,
                        trigger = ""
                )
        )
        print("Create contract txId: $txId")
    }
}