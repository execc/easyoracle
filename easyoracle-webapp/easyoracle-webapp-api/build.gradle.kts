val vstIdentityApiVersion: String by project

plugins {
    kotlin("plugin.spring")
}

dependencies {
    implementation(kotlin("stdlib"))

    api(project(":easyoracle-domain"))
    implementation("com.wavesplatform.vst:vst-identity-api:$vstIdentityApiVersion")
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation(project(":easyoracle-contract:easyoracle-contract-api"))
}
