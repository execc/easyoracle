package com.wavesplatform.we.app.easyoracle.contract.impl

import com.wavesplatform.vst.contract.data.Transaction
import com.wavesplatform.vst.contract.spring.annotation.ContractHandlerBean
import com.wavesplatform.vst.contract.state.ContractState
import com.wavesplatform.we.app.easyoracle.contract.EasyOracleContract
import com.wavesplatform.we.app.easyoracle.contract.Oracle
import com.wavesplatform.we.app.easyoracle.contract.OracleData
import java.security.KeyFactory
import java.security.PublicKey
import java.security.Signature
import java.security.spec.X509EncodedKeySpec
import org.bouncycastle.jce.provider.BouncyCastleProvider

const val KEY_ECDSA = "ECDSA"
const val SIG_ECDSA = "SHA256withECDSA"

@ContractHandlerBean
class EasyOracleContractImpl(
    private val state: ContractState,
    private val tx: Transaction
) : EasyOracleContract {

    override fun create(oracles: List<Oracle>, signatures: Int, window: Int) {
        require(signatures in 1..7) {
            "Signature should be in range 1..7"
        }
        require(window in 1..5) {
            "Window should be in range 1..5"
        }
        require(oracles.isNotEmpty()) {
            "Oracle list should not be empty"
        }

        val owner = tx.sender

        state.apply {
            put("OWNER", owner)
            put("ORACLES", oracles)
            put("SIGNATURES", signatures)
            put("WINDOW", window)
        }
    }

    override fun accept(data: List<OracleData>) {
        TODO("Not yet implemented")
    }

    fun verify(signature: ByteArray, data: ByteArray, key: ByteArray, curveName: String): Boolean {
        val keyFactory = KeyFactory.getInstance(KEY_ECDSA, BouncyCastleProvider())
        val publicKey = keyFactory.generatePublic(X509EncodedKeySpec(key)) as PublicKey
        val sig = Signature.getInstance(SIG_ECDSA, BouncyCastleProvider())
        sig.initVerify(publicKey)
        sig.update(data)
        return sig.verify(signature)
    }
}
