package com.wavesplatform.we.app.easyoracle

import com.wavesplatform.we.app.easyoracle.domain.OracleDataSource
import com.wavesplatform.we.app.easyoracle.service.OracleEvaluationService
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test

class OracleEvaluationServiceTest {

    @Test
    fun testShouldFetchData() {
        val service = OracleEvaluationService()
        val def = OracleDataSource(
                dataSourceType = "url",
                dataSourceExpression = "http://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json&tzshift=0",
                dataTransformationScript = "$.dataseries[0].seeing"
        )
        val data = service.eval(def)
        Assertions.assertNotNull(data.result)
    }
}