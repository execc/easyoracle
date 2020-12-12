package com.wavesplatform.we.app.easyoracle.api

import com.wavesplatform.we.app.easyoracle.contract.Oracle
import com.wavesplatform.we.app.easyoracle.domain.OracleDefinition

data class CreateOracleRequest(
        var oracles: List<Oracle>
        var definition: OracleDefinition
)