package com.wavesplatform.we.app.easyoracle.domain

import com.wavesplatform.we.app.easyoracle.domain.OracleTaskStatus.IN_PROCESS
import java.util.UUID
import javax.persistence.CascadeType.ALL
import javax.persistence.Entity
import javax.persistence.EnumType.STRING
import javax.persistence.Enumerated
import javax.persistence.FetchType.EAGER
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import javax.persistence.Version

@Entity
data class OracleTask(
        @Id
        val id: String = UUID.randomUUID().toString(),
        @Version
        val version: Int = 1,
        @ManyToOne
        val definition: OracleDefinition,
        @Enumerated(STRING)
        val status: OracleTaskStatus = IN_PROCESS,
        @OneToMany(cascade = [ALL], fetch = EAGER)
        val data: Set<OracleData>
)

enum class OracleTaskStatus {
        IN_PROCESS,
        COMPLETED
}

