package com.wavesplatform.we.app.easyoracle.controller.handler

import com.wavesplatform.we.app.easyoracle.api.exception.ErrorDto
import com.wavesplatform.we.app.easyoracle.api.exception.VstErrorCode.EXTERNAL_SERVICE_CALL
import com.wavesplatform.we.app.easyoracle.api.exception.VstRestApiException
import feign.Response
import feign.codec.ErrorDecoder
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Component

@Component("vstNodeErrorDecoder")
class VstNodeErrorResponseDecoder : ErrorDecoder {

    private val defaultErrorDecoder = ErrorDecoder.Default()

    override fun decode(methodKey: String, response: Response): Exception {
        val httpStatus = HttpStatus.valueOf(response.status())
        if (isResourceFoundButWithClientError(httpStatus)) {
            return VstRestApiException(
                    httpStatus,
                    ErrorDto(
                            EXTERNAL_SERVICE_CALL.value,
                            "${response.body()?.asReader()?.readText()}"
                    )
            )
        }
        return defaultErrorDecoder.decode(methodKey, response)
    }

    private fun isResourceFoundButWithClientError(httpStatus: HttpStatus): Boolean {
        return httpStatus.is4xxClientError && HttpStatus.NOT_FOUND != httpStatus
    }
}
