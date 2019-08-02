# gradle-warmed
Gradle container pre-warmed with common plugins.

This container can be used as a parent of your build container for building Gradle projects. This container was previously used to compile sample projects so that the most common Gradle plugins will be already present in cache and won't be downloaded at each build.

**IMPORTANT**

You have to compile your project with ```--build-cache``` in gradle command line or put ```org.gradle.caching=true``` in your gradle.properties for enabling gradle to use the pre-warmed cache.

For mor info about Gradle caching, see https://docs.gradle.org/current/userguide/build_cache.html

## Usage

* Create your Dockerfile (with multi stage build)

```
FROM flaviostutz/gradle-warmed AS BUILD

WORKDIR /tmp

RUN git clone https://github.com/codecov/example-gradle.git

WORKDIR /tmp/example-gradle
RUN gradle --version
RUN gradle build -x test --info --build-cache


FROM openjdk:13-alpine3.9
COPY --from=BUILD /tmp/example-gradle/build/libs /opt/example-gradle
```

* Run "docker build ."
