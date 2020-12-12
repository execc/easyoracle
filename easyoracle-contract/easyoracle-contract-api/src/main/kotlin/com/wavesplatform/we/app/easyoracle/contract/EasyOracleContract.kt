package com.wavesplatform.we.app.easyoracle.contract

import com.fasterxml.jackson.databind.JsonNode
import com.wavesplatform.vst.contract.ContractAction
import com.wavesplatform.vst.contract.ContractInit
import com.wavesplatform.vst.contract.InvokeParam

interface EasyOracleContract {

    /**
     * Initializes new Oracle contract
     */
    @ContractInit
    fun create(
        /**
         * List of oracle addresses
         */
        @InvokeParam(name = "oracles") oracles: List<Oracle>,

        /**
         * Number of signatures, required to commit data
         */
        @InvokeParam(name = "signatures") signatures: Int,

        /**
         * Time window (in blocks) during which data is current
         */
        @InvokeParam(name = "window") window: Int
    )

    /**
     * Accepts lists of data points from multiple oracles
     */
    @ContractAction
    fun accept(
        /**
         * List of oracle data points
         */
        @InvokeParam(name = "data") data: List<OracleData>
    )
}

data class Oracle(
    val address: String,
    val publicKey: String
)

data class OracleData(
    val publicKey: String,
    val signature: String,
    val data: JsonNode
)
