package com.wavesplatform.we.app.easyoracle

import com.wavesplatform.we.app.easyoracle.domain.OracleDataSource
import com.wavesplatform.we.app.easyoracle.service.OracleEvaluationService
import com.wavesplatform.we.app.easyoracle.service.datasources.HtmlDataSource
import com.wavesplatform.we.app.easyoracle.service.datasources.UrlDataSource
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test

class OracleEvaluationServiceTest {

    @Test
    fun testShouldFetchData() {
        val service = OracleEvaluationService(UrlDataSource(), HtmlDataSource())
        val def = OracleDataSource(
                dataSourceType = "url",
                dataSourceExpression = "http://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json&tzshift=0",
                dataTransformationScript = "$.dataseries[0].seeing",
                selector = setOf()
        )
        val data = service.eval(def)
        Assertions.assertNotNull(data)
    }

    @Test
    fun testShouldFetchDataFromCbrf() {
        val service = OracleEvaluationService(UrlDataSource(), HtmlDataSource())
        val def = OracleDataSource(
                dataSourceType = "html",
                dataSourceExpression = "https://cbr.ru/key-indicators/",
                dataTransformationScript = "div.indicator.col-md-7.offset-md-1  div.rate.col-md-7 div.value",
                selector = setOf()
        )
        val data = service.eval(def)
        print(data)
        Assertions.assertNotNull(data)
    }
}
