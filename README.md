# gradle-warmed
Gradle container pre-warmed with common plugins

This container can be used instead of plain "gradle" so that some plugins will be already downloaded.

## Usage

* Create your Dockerfile (with multi stage build)

```
FROM flaviostutz/gradle-warmed AS BUILD

WORKDIR /tmp

RUN git clone https://github.com/codecov/example-gradle.git

WORKDIR /tmp/example-gradle
RUN gradle --version
RUN gradle build -x test --info


FROM openjdk:13-alpine3.9
COPY --from=BUILD /tmp/example-gradle/build/libs /opt/example-gradle
```

* Run "docker build ."

