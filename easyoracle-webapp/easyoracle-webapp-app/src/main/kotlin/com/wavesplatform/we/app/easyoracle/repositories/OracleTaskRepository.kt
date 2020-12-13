package com.wavesplatform.we.app.easyoracle.repositories

import com.wavesplatform.we.app.easyoracle.domain.OracleTask
import com.wavesplatform.we.app.easyoracle.domain.OracleTaskStatus
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query

interface OracleTaskRepository : JpaRepository<OracleTask, String> {

    @Query("""
        select t from OracleTask t
        join   t.data d
        join   t.definition.dataSources ds
        join   ds.selector sel
        where  t.status = :status
          and (d.publicKey <> :publicKey or d.publicKey is null)
          and  sel = :publicKey
    """)
    fun findMyTasks(
        status: OracleTaskStatus,
        publicKey: String
    ): List<OracleTask>
}
