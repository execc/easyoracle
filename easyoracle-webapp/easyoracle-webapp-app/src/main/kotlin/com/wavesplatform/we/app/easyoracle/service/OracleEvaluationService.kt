package com.wavesplatform.we.app.easyoracle.service

import com.wavesplatform.we.app.easyoracle.domain.OracleDataSource
import com.wavesplatform.we.app.easyoracle.domain.OracleDefinition
import com.wavesplatform.we.app.easyoracle.service.datasources.HtmlDataSource
import com.wavesplatform.we.app.easyoracle.service.datasources.UrlDataSource
import org.codehaus.jackson.map.ObjectMapper
import org.springframework.stereotype.Service

@Service
class OracleEvaluationService(
        private val urlDataSource: UrlDataSource,
        private val htmlDataSource: HtmlDataSource
) {

    fun evalAll(definition: OracleDefinition): List<String> {
        return definition.dataSources.map {
            eval(it)
        }
    }

    fun eval(definition: OracleDataSource): String {
        val data = when (definition.dataSourceType) {
            "url" -> {
                urlDataSource.eval(definition.dataSourceExpression, definition.dataTransformationScript)
            }
            "html" -> {
                htmlDataSource.eval(definition.dataSourceExpression, definition.dataTransformationScript)
            }
            else -> {
                throw IllegalArgumentException("Illegal definition type")
            }
        }

        return ObjectMapper().writeValueAsString(data)
    }
}
