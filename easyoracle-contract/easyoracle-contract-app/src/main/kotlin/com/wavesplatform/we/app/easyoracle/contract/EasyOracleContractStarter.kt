package com.wavesplatform.we.app.easyoracle.contract

import com.wavesplatform.vst.contract.grpc.VstContractApplication
import com.wavesplatform.we.app.easyoracle.contract.impl.EasyOracleContractImpl
import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.EnableAutoConfiguration
import org.springframework.context.annotation.ComponentScan

@EnableAutoConfiguration
@ComponentScan("com.wavesplatform.we.app.easyoracle.contract")
class EasyOracleContractStarter : VstContractApplication() {

    override fun contractHandlerPackage(): Package {
        return EasyOracleContractImpl::class.java.`package`
    }

    companion object {
        @JvmStatic
        fun main(args: Array<String>) {
            SpringApplication.run(EasyOracleContractStarter::class.java)
        }
    }
}
