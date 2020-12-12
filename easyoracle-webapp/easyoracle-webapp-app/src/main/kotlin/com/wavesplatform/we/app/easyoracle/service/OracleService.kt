package com.wavesplatform.we.app.easyoracle.service

import com.wavesplatform.we.app.easyoracle.contract.Oracle
import org.springframework.stereotype.Service

@Service
class OracleService(
        private val easyOracleContractService: EasyOracleContractService
) {

    fun createOracle(name: String, oracles: List<Oracle>, signatures: Int, window: Int): String {
        return easyOracleContractService.create(name, oracles, signatures, window)
    }
}