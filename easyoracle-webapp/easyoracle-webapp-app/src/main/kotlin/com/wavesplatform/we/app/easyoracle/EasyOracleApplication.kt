package com.wavesplatform.we.app.easyoracle

import com.wavesplatform.vst.tx.observer.api.model.BlockHeightInfo
import com.wavesplatform.we.app.easyoracle.domain.BaseEntity
import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.autoconfigure.domain.EntityScan
import org.springframework.cloud.openfeign.EnableFeignClients
import org.springframework.scheduling.annotation.EnableAsync
import org.springframework.scheduling.annotation.EnableScheduling

@SpringBootApplication
@EnableFeignClients
@EnableScheduling
@EnableAsync
@EntityScan(basePackageClasses = [BaseEntity::class, BlockHeightInfo::class])
class EasyOracleApplication

fun main(args: Array<String>) {
    SpringApplication.run(EasyOracleApplication::class.java, *args)
}
