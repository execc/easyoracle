package com.wavesplatform.we.app.easyoracle.config

import com.wavesplatform.vst.contract.factory.ContractAuthenticate
import com.wavesplatform.vst.contract.factory.ContractClientFactory
import com.wavesplatform.vst.contract.factory.ImageInfo
import com.wavesplatform.vst.contract.state.TxContext
import com.wavesplatform.vst.contract.utils.JsonUtils
import com.wavesplatform.vst.node.IVstNodeClientWrapper
import com.wavesplatform.vst.node.VstNodeApi
import com.wavesplatform.vst.node.WeNodeApi
import com.wavesplatform.vst.node.config.NodeCredsKeysProperties
import com.wavesplatform.vst.security.commons.OAuth2TokenSupport
import com.wavesplatform.we.app.easyoracle.contract.EasyOracleContract
import com.wavesplatform.we.app.easyoracle.contract.impl.EasyOracleContractImpl
import java.util.function.Supplier
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.core.context.SecurityContextHolder

@Configuration
class BeansConfig(
    val vstNodeClientWrapper: IVstNodeClientWrapper,
    val tokenSupport: OAuth2TokenSupport,
    @Value("\${easyoracle-app.sender}")
    val techUserSender: String,
    @Value("\${easyoracle-app.node-alias}")
    val techNodeAlias: String
) {

    @Bean
    fun vstNodeApi(): WeNodeApi = vstNodeClientWrapper.getWeClient(techNodeAlias)

    @Bean
    fun contractAuthentificate(nodeCredsKeys: NodeCredsKeysProperties): Supplier<ContractAuthenticate> {
        return Supplier {
            val auth = SecurityContextHolder.getContext().authentication
            val builder = if (auth == null) {
                ContractAuthenticate.builder()
                        .sender(techUserSender)
                        .password(
                                nodeCredsKeys.config.getValue(techNodeAlias).keyStorePassword
                        )
            } else {
                ContractAuthenticate.builder()
                        .sender(tokenSupport.currentUserPersonInfo.participantAddress)
                        .password(
                                nodeCredsKeys.config.getValue(tokenSupport.currentUserPersonInfo.nodeAlias).keyStorePassword
                        )
            }
            builder.build()
        }
    }

    @Bean
    fun vstNodeApiSupplier(vstNodeApi: WeNodeApi): Supplier<WeNodeApi> {
        return Supplier {
            val auth = SecurityContextHolder.getContext().authentication
            if (auth == null) {
                vstNodeApi
            } else {
                vstNodeClientWrapper.getWeClient(tokenSupport.currentUserPersonInfo.nodeAlias)
            }
        }
    }

    @Bean
    fun contractClientFactory(
        nodeCredsKeys: NodeCredsKeysProperties,
        @Value("\${easyoracle-app.contract.image}") image: String,
        @Value("\${easyoracle-app.contract.imageHash}") imageHash: String,
        @Value("\${easyoracle-app.fee}") fee: Long,
        weNodeApiSupplier: Supplier<WeNodeApi>,
        contractAuthenticate: Supplier<ContractAuthenticate>
    ): ContractClientFactory<*> {
        val vstNodeApiSupplier = weNodeApiSupplier as Supplier<VstNodeApi>
        return ContractClientFactory.withType(EasyOracleContract::class.java)
                .setImplementationBuilderForUpdate {
                    val context = TxContext(JsonUtils.toJson(it), vstNodeApiSupplier)
                    EasyOracleContractImpl(context.contractState, context.tx)
                }
                .setImplementationBuilderForCreate {
                    val context = TxContext(JsonUtils.toJson(it), vstNodeApiSupplier)
                    EasyOracleContractImpl(context.contractState, context.tx)
                }
                .setWeNodeApiSupplier(weNodeApiSupplier)
                .setImageInfo(
                        ImageInfo.builder()
                                .image(image)
                                .imageHash(imageHash)
                                .build()
                )
                .setFee(fee)
                .setAuthenticateSupplier(contractAuthenticate)
                .setVersion(2)
    }
}
