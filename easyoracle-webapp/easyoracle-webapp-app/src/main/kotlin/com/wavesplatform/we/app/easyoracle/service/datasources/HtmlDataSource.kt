package com.wavesplatform.we.app.easyoracle.service.datasources

import org.jsoup.Jsoup
import org.springframework.stereotype.Component

@Component
class HtmlDataSource {

    fun eval(expression: String, transformation: String): Any {
        val doc = Jsoup.connect(expression).get()
        val result = doc.select(transformation)
        return result.text()
    }
}
