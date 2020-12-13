package com.wavesplatform.we.app.easyoracle.domain

import java.util.UUID
import javax.persistence.ElementCollection
import javax.persistence.Entity
import javax.persistence.Id

@Entity
data class OracleDataSource(
    @Id
    val id: String = UUID.randomUUID().toString(),
    val dataSourceType: String,
    val dataSourceExpression: String,
    val dataTransformationScript: String,
    @ElementCollection
    val selector: Set<String>
)
