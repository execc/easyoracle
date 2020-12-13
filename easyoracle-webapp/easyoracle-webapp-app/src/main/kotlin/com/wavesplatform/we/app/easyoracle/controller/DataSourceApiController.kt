package com.wavesplatform.we.app.easyoracle.controller

import com.wavesplatform.we.app.easyoracle.domain.OracleDataSource
import com.wavesplatform.we.app.easyoracle.service.OracleEvaluationService
import org.springframework.http.HttpStatus.OK
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/datasource")
class DataSourceApiController(
    private val oracleEvaluationService: OracleEvaluationService
) {

    @PostMapping("/test")
    fun create(@RequestBody request: OracleDataSource): ResponseEntity<String> {
        return try {
            val result = oracleEvaluationService.eval(request)
            ResponseEntity(result, OK)
        } catch (e: Exception) {
            ResponseEntity("<Ошибка> ${e.message}", OK)
        }
    }
}
