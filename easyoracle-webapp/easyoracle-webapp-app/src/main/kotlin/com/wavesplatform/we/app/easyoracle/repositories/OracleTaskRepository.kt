package com.wavesplatform.we.app.easyoracle.repositories

import com.wavesplatform.we.app.easyoracle.domain.OracleTask
import com.wavesplatform.we.app.easyoracle.domain.OracleTaskStatus
import org.springframework.data.jpa.repository.JpaRepository

interface OracleTaskRepository: JpaRepository<OracleTask, String> {

    fun findByStatusAndDataPublicKey(
            status: OracleTaskStatus,
            publicKey: String
    ): List<OracleTask>
}