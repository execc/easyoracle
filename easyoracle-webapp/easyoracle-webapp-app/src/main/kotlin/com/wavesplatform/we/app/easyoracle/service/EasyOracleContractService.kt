package com.wavesplatform.we.app.easyoracle.service

import com.wavesplatform.vst.contract.factory.ContractClientFactory
import com.wavesplatform.we.app.easyoracle.contract.EasyOracleContract
import com.wavesplatform.we.app.easyoracle.contract.Oracle
import com.wavesplatform.we.app.easyoracle.contract.OracleData
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

    fun accept(contractId: String, requestId: String, data: List<OracleData>): String {
        val api = factory.client { it.contractId(contractId) }
        api.contract().accept(requestId, data)
        return api.lastTxId
    }
}
