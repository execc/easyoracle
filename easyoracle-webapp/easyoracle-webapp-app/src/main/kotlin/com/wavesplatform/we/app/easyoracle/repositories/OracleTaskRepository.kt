package com.wavesplatform.we.app.easyoracle.repositories

import com.wavesplatform.we.app.easyoracle.domain.OracleTask
import com.wavesplatform.we.app.easyoracle.domain.OracleTaskStatus
import org.springframework.data.jpa.repository.JpaRepository

interface OracleTaskRepository : JpaRepository<OracleTask, String> {

    fun findByStatus(status: OracleTaskStatus): List<OracleTask>
}

fun OracleTaskRepository.findMyTasks(
    status: OracleTaskStatus,
    publicKey: String
): List<OracleTask> {
    return findByStatus(status).filter {
        it.definition.dataSources.any {
            ds -> ds.selector.contains(publicKey)
        } && it.data.none {
            d -> d.publicKey == publicKey
        }
    }
}
