package com.wavesplatform.we.app.easyoracle.service

import com.wavesplatform.we.app.easyoracle.contract.impl.KEY_ECDSA
import com.wavesplatform.we.app.easyoracle.contract.impl.SIG_ECDSA
import java.security.KeyFactory
import java.security.NoSuchAlgorithmException
import java.security.PrivateKey
import java.security.Signature
import java.security.interfaces.ECPrivateKey
import java.security.spec.InvalidKeySpecException
import java.security.spec.PKCS8EncodedKeySpec
import java.util.Base64
import org.bouncycastle.jce.provider.BouncyCastleProvider
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service

@Service
class CryptoService(
    @Value("\${easyoracle-app.private-key}")
    private val privateKey: String
) {

    fun loadPrivateKey(): ECPrivateKey {
        val privateKeySpec = PKCS8EncodedKeySpec(Base64.getDecoder().decode(privateKey))
        return try {
            val keyFactory = KeyFactory.getInstance(KEY_ECDSA, BouncyCastleProvider())
            keyFactory.generatePrivate(privateKeySpec)
        } catch (e: NoSuchAlgorithmException) {
            throw IllegalStateException("NoSuchAlgorithm", e)
        } catch (e: InvalidKeySpecException) {
            throw IllegalStateException("InvalidKeySpec", e)
        } as ECPrivateKey
    }

    fun sign(privateKey: PrivateKey, data: String): String {
        val ecdsaSign = Signature.getInstance(SIG_ECDSA, BouncyCastleProvider())
        ecdsaSign.initSign(privateKey)
        ecdsaSign.update(data.toByteArray())
        val signature = ecdsaSign.sign()
        return Base64.getEncoder().encodeToString(signature)
    }

    fun sign(data: String) = sign(loadPrivateKey(), data)
}
