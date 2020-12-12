import java.io.File
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import org.springframework.boot.gradle.tasks.bundling.BootJar

val vstCommonsVersion: String by project
val mavenUser: String by project
val mavenPassword: String by project

plugins {
    kotlin("plugin.spring")
    id("org.springframework.boot")
    id("com.palantir.git-version")
    id("com.wavesplatform.vst.contract-docker")
    `maven-publish`
}

dependencies {
    implementation(kotlin("stdlib"))
    implementation("com.wavesplatform.we:vst-contract-grpc:$vstCommonsVersion")
    api(project(":easyoracle-contract:easyoracle-contract-api"))
    api(project(":easyoracle-domain"))
    implementation("org.springframework:spring-aspects")
    implementation("com.github.METADIUM:verifiable-credential-java:0.1.8")

    testImplementation("org.springframework.boot:spring-boot-starter-test")
}

val gitVersion = (project.extensions.extraProperties.get("gitVersion") as? groovy.lang.Closure<*>)?.call()

fun getDate(): String {
    val current = LocalDateTime.now()
    val formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss")

    return formatter.format(current)
}
val dockerName = "registry.wavesenterprise.com/image-sc/easyoracle-contract-app"
val bootJar: BootJar by tasks
docker {
    name = dockerName
    tags(if (version.toString().endsWith("-SNAPSHOT")) {
        "$version-${getDate()}-$gitVersion"
    } else {
        "$version-$gitVersion"
    })
    files(bootJar.outputs)
}

fun String.runCommand(workingDir: File = file("./")): String {
    val parts = this.split("\\s".toRegex())
    val proc = ProcessBuilder(*parts.toTypedArray())
            .directory(workingDir)
            .redirectOutput(ProcessBuilder.Redirect.PIPE)
            .redirectError(ProcessBuilder.Redirect.PIPE)
            .start()

    proc.waitFor(1, TimeUnit.MINUTES)
    return proc.inputStream.bufferedReader().readText().trim()
}

val replaceImageId = tasks.create("replaceImageId") {
    doLast {
        var imageId = ""
        try {
            imageId = "docker inspect $dockerName --format=\"{{.ID}}\"".runCommand()
            println("Contract $dockerName image ID: $imageId")
        } catch (e: Exception) {
            println("Unable to find image ID for contract: $dockerName")
        }

        if (imageId.isNotBlank()) {
            val hash = imageId.substring(8, imageId.length - 1)
            val path = "${project.rootProject.projectDir.absolutePath}/easyoracle-webapp/easyoracle-webapp-app/src/main/resources/application.yml"
            val content = File(path).readText()
            val regex = "imageHash:.*".toRegex()
            val updatedContent = content.replace(regex, "imageHash: $hash")
            File(path).writeText(updatedContent)
        }
    }
}

tasks["dockerTag"].finalizedBy(replaceImageId)
replaceImageId.dependsOn(tasks["dockerTag"])

bootJar.apply {
    archiveClassifier.set("application")
}

val jar: Jar by tasks

jar.apply {
    enabled = true
}

publishing {
    repositories {
        maven {
            name = "maven"
            url = uri("https://artifacts.wavesenterprise.com/repository/${if (project.version.toString().endsWith("-SNAPSHOT")) "maven-snapshots" else "maven-releases"}")
            credentials {
                username = mavenUser
                password = mavenPassword
            }
        }
    }
    publications {
        create<MavenPublication>("maven") {
            from(components["java"])
        }
    }
}
