package com.wavesplatform.we.app.easyoracle.service

import com.jayway.jsonpath.JsonPath
import com.wavesplatform.we.app.easyoracle.domain.OracleData
import com.wavesplatform.we.app.easyoracle.domain.OracleDefinition
import org.codehaus.jackson.map.ObjectMapper
import org.springframework.http.HttpMethod
import org.springframework.http.HttpStatus.OK
import org.springframework.http.RequestEntity
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Service
import org.springframework.web.client.RestTemplate
import org.springframework.web.client.exchange
import java.lang.IllegalArgumentException
import java.lang.IllegalStateException
import java.net.URI
import kotlin.math.exp

@Service
class OracleEvaluationService() {

    fun eval(definition: OracleDefinition): OracleData {
        val data = if (definition.dataSourceType == "url") {
            val jsonStr = evalUrl(definition.dataSourceExpression)
            val jsonPath = if (definition.dataTransformationScript.isNotBlank()) {
                definition.dataTransformationScript
            } else { "$" }
            val result: Any = JsonPath.read(jsonStr, jsonPath)
            result
        } else {
            throw IllegalArgumentException("Illegal definition type")
        }

        val resultNormalized = ObjectMapper().writeValueAsString(data)
        return OracleData(
                result = resultNormalized,
                publicKey = "",
                signature = ""
        )
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