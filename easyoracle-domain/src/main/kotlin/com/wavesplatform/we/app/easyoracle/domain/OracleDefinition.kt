package com.wavesplatform.we.app.easyoracle.domain

import java.util.UUID
import javax.persistence.CascadeType.ALL
import javax.persistence.Entity
import javax.persistence.FetchType.EAGER
import javax.persistence.Id
import javax.persistence.OneToMany

@Entity
data class OracleDefinition(
        @Id
        val id: String = UUID.randomUUID().toString(),
        val name: String,
        @OneToMany(cascade = [ALL], fetch = EAGER)
        val dataSources: List<OracleDataSource>,
        val signatures: Int,
        val windowSize: Int,
        val trigger: String,
        val contractId: String = ""
)