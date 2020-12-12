package com.wavesplatform.we.app.easyoracle.service

import com.wavesplatform.we.app.easyoracle.contract.Oracle
import com.wavesplatform.we.app.easyoracle.domain.OracleDefinition
import com.wavesplatform.we.app.easyoracle.repositories.OracleDefinitionRepository
import com.wavesplatform.we.app.easyoracle.repositories.OracleTaskRepository
import org.springframework.stereotype.Service

@Service
class OracleService(
        private val easyOracleContractService: EasyOracleContractService,
        private val oracleDefinitionRepository: OracleDefinitionRepository,
        private val oracleTaskRepository: OracleTaskRepository
) {

    fun createOracle(oracles: List<Oracle>, definition: OracleDefinition): OracleDefinition {
        val txId = easyOracleContractService.create(
                definition.contractName,
                oracles,
                definition.signatures,
                definition.windowSize
        )
        val definitionToSave = definition.copy(contractId = txId)
        return oracleDefinitionRepository.saveAndFlush(definitionToSave)
    }

    fun list(): List<OracleDefinition> {
        return oracleDefinitionRepository.findAll()
    }

    fun delete(oracleId: String) {
        oracleTaskRepository.deleteAll()
        oracleDefinitionRepository.deleteById(oracleId)
    }
}