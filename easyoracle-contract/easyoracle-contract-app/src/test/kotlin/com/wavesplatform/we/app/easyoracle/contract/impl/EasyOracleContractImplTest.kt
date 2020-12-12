package com.wavesplatform.we.app.easyoracle.contract.impl

import com.fasterxml.jackson.databind.JsonNode
import com.wavesplatform.vst.contract.data.Transaction
import com.wavesplatform.vst.contract.state.InMemoryContractState
import com.wavesplatform.vst.contract.utils.JsonUtils
import com.wavesplatform.we.app.easyoracle.contract.Oracle
import com.wavesplatform.we.app.easyoracle.contract.OracleData
import org.bouncycastle.jce.provider.BouncyCastleProvider
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import java.security.KeyPair
import java.security.KeyPairGenerator
import java.security.SecureRandom
import java.security.Security
import java.security.spec.ECGenParameterSpec
import java.util.Base64


class EasyOracleContractImplTest {

    init {
        Security.addProvider(BouncyCastleProvider())
    }


    @Test
    fun testAllSignaturesValid2OutOf3() {
        val state = InMemoryContractState("", mapOf())
        var contract = EasyOracleContractImpl(state, mockTx("ORACLE1",103))

        // Create 3 different oracles
        //
        val key1 = generateKey()
        val key2 = generateKey()
        val key3 = generateKey()

        val pubKey1 = Base64.getEncoder().encodeToString(key1.public.encoded)
        val pubKey2 = Base64.getEncoder().encodeToString(key2.public.encoded)
        val pubKey3 = Base64.getEncoder().encodeToString(key3.public.encoded)

        val oracles = listOf(
                Oracle(address = "ORACLE1", publicKey = pubKey1),
                Oracle(address = "ORACLE2", publicKey = pubKey2),
                Oracle(address = "ORACLE3", publicKey = pubKey3)
        )

        contract.create(
                oracles = oracles,
                window = 1,
                signatures = 2
        )

        // Create 3 data points
        //
        val data1 = """{"value":3}"""
        val data2 = """{"value":2}"""

        val dataPoints = listOf(
                OracleData(
                        data = JsonUtils.fromJson(data1, JsonNode::class.java),
                        publicKey = pubKey1,
                        signature = contract.sign(key1.private, data1)
                ),
                OracleData(
                        data = JsonUtils.fromJson(data1, JsonNode::class.java),
                        publicKey = pubKey2,
                        signature = contract.sign(key2.private, data1)
                ),
                OracleData(
                        data = JsonUtils.fromJson(data2, JsonNode::class.java),
                        publicKey = pubKey3,
                        signature = contract.sign(key3.private, data2)
                )
        )

        contract = EasyOracleContractImpl(state, mockTx("ORACLE1",104))
        contract.accept(dataPoints)
    }

    @Test
    fun testInvalidSignatures2OutOf3() {
        val state = InMemoryContractState("", mapOf())
        var contract = EasyOracleContractImpl(state, mockTx("ORACLE1",103))

        // Create 3 different oracles
        //
        val key1 = generateKey()
        val key2 = generateKey()
        val key3 = generateKey()

        val pubKey1 = Base64.getEncoder().encodeToString(key1.public.encoded)
        val pubKey2 = Base64.getEncoder().encodeToString(key2.public.encoded)
        val pubKey3 = Base64.getEncoder().encodeToString(key3.public.encoded)

        val oracles = listOf(
                Oracle(address = "ORACLE1", publicKey = pubKey1),
                Oracle(address = "ORACLE2", publicKey = pubKey2),
                Oracle(address = "ORACLE3", publicKey = pubKey3)
        )

        contract.create(
                oracles = oracles,
                window = 1,
                signatures = 2
        )

        // Create 3 data points
        //
        val data1 = """{"value":3}"""
        val data2 = """{"value":2}"""

        val dataPoints = listOf(
                OracleData(
                        data = JsonUtils.fromJson(data1, JsonNode::class.java),
                        publicKey = pubKey1,
                        signature = contract.sign(key1.private, data1)
                ),
                OracleData(
                        data = JsonUtils.fromJson(data1, JsonNode::class.java),
                        publicKey = pubKey2,
                        signature = contract.sign(key2.private, data1 + "X") // Wrong signature
                ),
                OracleData(
                        data = JsonUtils.fromJson(data2, JsonNode::class.java),
                        publicKey = pubKey3,
                        signature = contract.sign(key3.private, data2)
                )
        )

        contract = EasyOracleContractImpl(state, mockTx("ORACLE1",104))
        Assertions.assertThrows(IllegalArgumentException::class.java) {
            contract.accept(dataPoints)
        }
    }

    @Test
    fun testAllSignaturesValidButOnly1Point() {
        val state = InMemoryContractState("", mapOf())
        var contract = EasyOracleContractImpl(state, mockTx("ORACLE1",103))

        // Create 3 different oracles
        //
        val key1 = generateKey()
        val key2 = generateKey()
        val key3 = generateKey()

        val pubKey1 = Base64.getEncoder().encodeToString(key1.public.encoded)
        val pubKey2 = Base64.getEncoder().encodeToString(key2.public.encoded)
        val pubKey3 = Base64.getEncoder().encodeToString(key3.public.encoded)

        val oracles = listOf(
                Oracle(address = "ORACLE1", publicKey = pubKey1),
                Oracle(address = "ORACLE2", publicKey = pubKey2),
                Oracle(address = "ORACLE3", publicKey = pubKey3)
        )

        contract.create(
                oracles = oracles,
                window = 1,
                signatures = 2
        )

        // Create 3 data points
        //
        val data1 = """{"value":3}"""
        val data2 = """{"value":2}"""
        val data3 = """{"value":1}"""

        val dataPoints = listOf(
                OracleData(
                        data = JsonUtils.fromJson(data1, JsonNode::class.java),
                        publicKey = pubKey1,
                        signature = contract.sign(key1.private, data1)
                ),
                OracleData(
                        data = JsonUtils.fromJson(data2, JsonNode::class.java),
                        publicKey = pubKey2,
                        signature = contract.sign(key2.private, data2) // Wrong signature
                ),
                OracleData(
                        data = JsonUtils.fromJson(data3, JsonNode::class.java),
                        publicKey = pubKey3,
                        signature = contract.sign(key3.private, data3)
                )
        )

        contract = EasyOracleContractImpl(state, mockTx("ORACLE1",104))
        Assertions.assertThrows(IllegalArgumentException::class.java) {
            contract.accept(dataPoints)
        }
    }

    fun mockTx(sender: String, type: Int) = Transaction("", 0, sender, "", "", "", emptyList(), 0, 0, "", type)

    fun generateKey(): KeyPair {
        val ecSpec = ECGenParameterSpec("secp256k1")
        val g = KeyPairGenerator.getInstance("EC")
        g.initialize(ecSpec, SecureRandom())
        return g.generateKeyPair()
    }

    @Test
    fun generateKeyPair() {
        val ecSpec = ECGenParameterSpec("secp256k1")
        val g = KeyPairGenerator.getInstance("EC")
        g.initialize(ecSpec, SecureRandom())
        val keypair = g.generateKeyPair()
        val publicKey = keypair.public
        val privateKey = keypair.private

        val data = "ABC"

        val state = InMemoryContractState("", mapOf())
        val contract = EasyOracleContractImpl(state, mockTx("",103))

        val pub = Base64.getEncoder().encodeToString(publicKey.encoded)
        val prv = Base64.getEncoder().encodeToString(privateKey.encoded)

        val sig = contract.sign(privateKey, data)
        val result = contract.verify(sig, data, pub)

        Assertions.assertTrue(result)

        print(pub)
        print(prv)
    }
}
