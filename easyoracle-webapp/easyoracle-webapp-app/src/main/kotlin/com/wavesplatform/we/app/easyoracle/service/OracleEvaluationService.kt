package com.wavesplatform.we.app.easyoracle.service

import com.jayway.jsonpath.JsonPath
import com.wavesplatform.we.app.easyoracle.domain.OracleDataSource
import com.wavesplatform.we.app.easyoracle.domain.OracleDefinition
import org.codehaus.jackson.map.ObjectMapper
import org.springframework.http.HttpStatus.OK
import org.springframework.http.RequestEntity
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Service
import org.springframework.web.client.RestTemplate
import org.springframework.web.client.exchange
import java.lang.IllegalArgumentException
import java.lang.IllegalStateException
import java.net.URI

@Service
class OracleEvaluationService {

    fun evalAll(definition: OracleDefinition): List<String> {
        return definition.dataSources.map {
            eval(it)
        }
    }

    fun eval(definition: OracleDataSource): String {
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

        return ObjectMapper().writeValueAsString(data)
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