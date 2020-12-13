package com.wavesplatform.we.app.easyoracle.service.datasources

import org.springframework.http.HttpStatus.OK
import org.springframework.http.RequestEntity
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Component
import org.springframework.web.client.RestTemplate
import org.springframework.web.client.exchange
import org.w3c.dom.Document
import org.w3c.dom.NodeList
import java.io.ByteArrayInputStream
import java.net.URI
import javax.xml.parsers.DocumentBuilderFactory
import javax.xml.xpath.XPath
import javax.xml.xpath.XPathConstants
import javax.xml.xpath.XPathFactory


@Component
class XmlDataSource {

    fun eval(expression: String, transformation: String): Any {
        val xmlStr = evalUrl(expression)
        val builderFactory = DocumentBuilderFactory.newInstance()
        val builder = builderFactory.newDocumentBuilder()
        val xmlDocument: Document = builder.parse(ByteArrayInputStream(xmlStr.toByteArray()))
        val xPath: XPath = XPathFactory.newInstance().newXPath()
        val nodeList: Any = xPath.compile(transformation).evaluate(xmlDocument, XPathConstants.STRING) as Any
        return nodeList.toString()
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
