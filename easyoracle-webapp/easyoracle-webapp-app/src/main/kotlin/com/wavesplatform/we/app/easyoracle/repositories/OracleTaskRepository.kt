package com.wavesplatform.we.app.easyoracle.repositories

import com.wavesplatform.we.app.easyoracle.domain.OracleTask
import com.wavesplatform.we.app.easyoracle.domain.OracleTaskStatus
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query

interface OracleTaskRepository : JpaRepository<OracleTask, String> {

    @Query("""
        select t from OracleTask t
        join        t.definition.dataSources ds
        join        ds.selector sel
        where  t.status = :status
          and  not exists (select t1 from OracleTask t1 
                           left join t1.data d 
                          where d.publicKey = :publicKey)
          and  sel = :publicKey
    """)
    fun findMyTasks(
        status: OracleTaskStatus,
        publicKey: String
    ): List<OracleTask>
}
