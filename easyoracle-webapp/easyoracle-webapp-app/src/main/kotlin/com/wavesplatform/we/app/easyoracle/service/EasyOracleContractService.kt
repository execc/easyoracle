package com.wavesplatform.we.app.easyoracle.service

import com.wavesplatform.vst.contract.factory.ContractClientFactory
import com.wavesplatform.we.app.easyoracle.contract.EasyOracleContract
import org.springframework.stereotype.Service

@Service
class EasyOracleContractService(
    val factory: ContractClientFactory<EasyOracleContract>
) {
    fun create(): String {
        val api = factory.client { it.contractName("easyoracle") }
        api.contract().create(listOf(), 1, 1)
        return api.lastTxId
    }
}
