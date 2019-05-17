FROM gradle:5.4.1-alpine AS BUILD

USER root

RUN apk update && apk upgrade && \
    apk add --no-cache bash git

WORKDIR /tmp

RUN git clone https://github.com/codecov/example-gradle.git

WORKDIR /tmp/example-gradle
RUN gradle --version
RUN gradle build -x test --info
