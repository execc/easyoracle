package com.wavesplatform.we.app.easyoracle

import com.wavesplatform.vst.security.commons.OAuth2TokenSupport
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.boot.test.mock.mockito.MockBean
import org.springframework.test.context.ActiveProfiles

@ActiveProfiles("test")
@SpringBootTest
abstract class AbstractIntegrationTest {

    @MockBean
    lateinit var tokenSupport: OAuth2TokenSupport
}
