package com.wavesplatform.we.app.easyoracle.service.datasources

import com.jayway.jsonpath.JsonPath
import java.lang.IllegalStateException
import java.net.URI
import org.springframework.http.HttpStatus.OK
import org.springframework.http.RequestEntity
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Component
import org.springframework.web.client.RestTemplate
import org.springframework.web.client.exchange

@Component
class UrlDataSource {

    fun eval(expression: String, transformation: String): Any {
        val jsonStr = evalUrl(expression)
        val jsonPath = if (transformation.isNotBlank()) {
            transformation
        } else {
            "$"
        }
        return JsonPath.read(jsonStr, jsonPath)
    }

    private fun evalUrl(expression: String): String {
        val template = RestTemplate()
        val get = RequestEntity.get(URI.create(expression)).build()
        val result: ResponseEntity<String> = template.exchange(get)
        if (result.statusCode == OK) {
            return result.body!!
        }
        throw IllegalStateException("Service responded with error")
    }
}
