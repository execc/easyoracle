package com.wavesplatform.we.app.easyoracle.contract.impl

import com.fasterxml.jackson.core.type.TypeReference
import com.wavesplatform.vst.contract.data.Transaction
import com.wavesplatform.vst.contract.spring.annotation.ContractHandlerBean
import com.wavesplatform.vst.contract.state.ContractState
import com.wavesplatform.vst.contract.utils.JsonUtils
import com.wavesplatform.we.app.easyoracle.contract.EasyOracleContract
import com.wavesplatform.we.app.easyoracle.contract.Oracle
import com.wavesplatform.we.app.easyoracle.contract.OracleData
import java.security.KeyFactory
import java.security.PrivateKey
import java.security.PublicKey
import java.security.Signature
import java.security.spec.X509EncodedKeySpec
import java.util.Base64
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
        val signatures = state.get("SIGNATURES", Int::class.java)
        val oracles = state.get("ORACLES", object : TypeReference<List<Oracle>>() {})

        // First require that the sender of transaction is one of the valid oracles
        //
        require(oracles.map { it.address }.contains(tx.sender)) {
            "Sender ${tx.sender} is not a valid Oracle"
        }

        // Collect data points with the same data
        //
        val byData = data.groupBy {
            it.data
        }

        // Get data point group that *may* have enough oracle signatures
        //
        val possibleData = byData.values.find {
            it.size >= signatures
        }
        require(possibleData != null) {
            "Not enough matching data points"
        }

        // Collect number of *valid* signatures from *valid* oracles
        // for this data point
        //
        val actualSignatures = possibleData.mapNotNull {
            if (oracles.map { o -> o.publicKey }.contains(it.publicKey) && // Valid oracle
                    verify(it.signature, JsonUtils.toJson(it.data), it.publicKey) // Valid signature
            ) {
                it.publicKey
            } else {
                null
            }
        }.toSet().size // To set is used to prevent single oracle to sign multiple messages

        // Check that number of collected signatures is greater or equal
        // to number of required signatures
        //
        require(actualSignatures >= signatures) {
            "Not enough signatures for data point"
        }

        // Commit value
        //
        state.put("VALUE", possibleData[0].data)
    }

    fun verify(signature: String, data: String, publicKey: String) =
            verify(
                    signature = Base64.getDecoder().decode(signature),
                    data = data.toByteArray(),
                    key = Base64.getDecoder().decode(publicKey),
                    curveName = "secp256k1"
            )

    fun verify(signature: ByteArray, data: ByteArray, key: ByteArray, curveName: String): Boolean {
        val keyFactory = KeyFactory.getInstance(KEY_ECDSA, BouncyCastleProvider())
        val publicKey = keyFactory.generatePublic(X509EncodedKeySpec(key)) as PublicKey
        val sig = Signature.getInstance(SIG_ECDSA, BouncyCastleProvider())
        sig.initVerify(publicKey)
        sig.update(data)
        return sig.verify(signature)
    }

    fun sign(privateKey: PrivateKey, data: String): String {
        val ecdsaSign = Signature.getInstance(SIG_ECDSA, BouncyCastleProvider())
        ecdsaSign.initSign(privateKey)
        ecdsaSign.update(data.toByteArray())
        val signature = ecdsaSign.sign()
        return Base64.getEncoder().encodeToString(signature)
    }
}
