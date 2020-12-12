package com.wavesplatform.we.app.easyoracle

import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.cloud.openfeign.EnableFeignClients

@SpringBootApplication
@EnableFeignClients
class EasyOracleApplication

fun main(args: Array<String>) {
    SpringApplication.run(EasyOracleApplication::class.java, *args)
}
