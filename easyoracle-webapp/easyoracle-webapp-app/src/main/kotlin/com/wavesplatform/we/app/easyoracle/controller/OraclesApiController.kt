package com.wavesplatform.we.app.easyoracle.controller

import com.wavesplatform.we.app.easyoracle.api.CreateOracleRequest
import com.wavesplatform.we.app.easyoracle.domain.OracleDefinition
import com.wavesplatform.we.app.easyoracle.service.OracleService
import org.springframework.http.HttpStatus.ACCEPTED
import org.springframework.http.HttpStatus.NO_CONTENT
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/oracles")
class OraclesApiController(
    val oracleService: OracleService
) {

    @PostMapping
    fun create(@RequestBody request: CreateOracleRequest): ResponseEntity<OracleDefinition> {
        request.definition.dataSources.forEach {
            require(it.selector.isNotEmpty()) {
                "Selector list should not be empty"
            }
        }
        val result = oracleService.createOracle(request.oracles, request.definition)
        return ResponseEntity(result, ACCEPTED)
    }

    @GetMapping
    fun list(): List<OracleDefinition> {
        return oracleService.list()
    }

    @DeleteMapping("{oracle_id}")
    fun delete(@PathVariable("oracle_id") oracleId: String): ResponseEntity<Void> {
        oracleService.delete(oracleId)
        return ResponseEntity(NO_CONTENT)
    }
}
