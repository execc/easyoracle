package com.wavesplatform.we.app.easyoracle.repositories

import com.wavesplatform.we.app.easyoracle.domain.OracleDefinition
import org.springframework.data.jpa.repository.JpaRepository

interface OracleDefinitionRepository : JpaRepository<OracleDefinition, String>
