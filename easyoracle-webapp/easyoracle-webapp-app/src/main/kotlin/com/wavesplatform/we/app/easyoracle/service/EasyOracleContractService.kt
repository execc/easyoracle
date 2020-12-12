package com.wavesplatform.we.app.easyoracle.service

import com.wavesplatform.vst.contract.factory.ContractClientFactory
import com.wavesplatform.we.app.easyoracle.contract.EasyOracleContract
import com.wavesplatform.we.app.easyoracle.contract.Oracle
import org.springframework.stereotype.Service
import java.util.UUID

@Service
class EasyOracleContractService(
    val factory: ContractClientFactory<EasyOracleContract>
) {
    fun create(name: String, oracles: List<Oracle>, signatures: Int, window: Int): String {
        val api = factory.client { it.contractName(name) }
        api.contract().create(oracles, signatures, window)
        return api.lastTxId
    }
}
