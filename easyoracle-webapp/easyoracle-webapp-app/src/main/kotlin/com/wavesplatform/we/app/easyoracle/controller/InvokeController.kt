package com.wavesplatform.we.app.easyoracle.controller

import com.wavesplatform.we.app.easyoracle.api.TxDto
import com.wavesplatform.we.app.easyoracle.service.EasyOracleContractService
import org.springframework.http.HttpStatus.ACCEPTED
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/invoke")
class InvokeController(
    val contractService: EasyOracleContractService
) {

    @PostMapping
    fun create(): ResponseEntity<TxDto> {
        val id = contractService.create()
        return ResponseEntity(TxDto(id), ACCEPTED)
    }

    @PostMapping("{contractId}/invoke")
    fun invoke(
        @PathVariable("contractId") contractId: String
    ): ResponseEntity<TxDto> {
        // val id = contractService.invoke(contractId)
        return ResponseEntity(TxDto(""), ACCEPTED)
    }
}
