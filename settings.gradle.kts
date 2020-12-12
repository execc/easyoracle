pluginManagement {
    val mavenUser: String by settings
    val mavenPassword: String by settings
    repositories {
        gradlePluginPortal()
        mavenLocal()
        mavenCentral()
        maven {
            name = "maven-snapshots"
            url = uri("https://artifacts.wavesenterprise.com/repository/maven-snapshots/")
            mavenContent {
                snapshotsOnly()
            }
            credentials {
                username = mavenUser
                password = mavenPassword
            }
        }
        maven {
            name = "maven-releases"
            url = uri("https://artifacts.wavesenterprise.com/repository/maven-releases/")
            mavenContent {
                releasesOnly()
            }
            credentials {
                username = mavenUser
                password = mavenPassword
            }
        }
    }
}

rootProject.name = "easyoracle-app"

include(
    "easyoracle-webapp:easyoracle-webapp-api",
    "easyoracle-webapp:easyoracle-webapp-app",

    "easyoracle-contract:easyoracle-contract-api",
    "easyoracle-contract:easyoracle-contract-app",

    "easyoracle-domain"
)