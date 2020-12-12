package com.wavesplatform.we.app.easyoracle.api.exception

import org.springframework.http.HttpStatus

data class VstRestApiException(
    val httpStatus: HttpStatus,
    val errorDto: ErrorDto
) : RuntimeException()
