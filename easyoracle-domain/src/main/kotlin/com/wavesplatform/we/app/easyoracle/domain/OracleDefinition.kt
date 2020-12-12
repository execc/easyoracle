package com.wavesplatform.we.app.easyoracle.domain

import java.util.UUID
import javax.persistence.Entity
import javax.persistence.Id

@Entity
data class OracleDefinition(
        @Id
        val id: String = UUID.randomUUID().toString(),
        val dataSourceType: String,
        val dataSourceExpression: String,
        val dataTransformationScript: String,
        val signatures: Int,
        val windowSize: Int,
        val trigger: String,
        val contractId: String
)