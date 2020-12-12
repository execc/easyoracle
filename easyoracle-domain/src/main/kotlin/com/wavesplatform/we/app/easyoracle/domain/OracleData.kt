package com.wavesplatform.we.app.easyoracle.domain

import java.util.UUID
import javax.persistence.Entity
import javax.persistence.Id

@Entity
data class OracleData(
    @Id
    val id: String = UUID.randomUUID().toString(),
    val result: String, // JSON Node as String
    val publicKey: String,
    val signature: String
)
