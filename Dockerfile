FROM openjdk:8-jdk-stretch AS BUILD
RUN apt-get update && apt-get install -y gradle git

# FROM gradle:5.4.1-alpine AS BUILD
# FROM gradle:4.10-alpine AS BUILD
# USER root
# RUN apk update && apk upgrade && \
#     apk add --no-cache gradle bash git

RUN gradle --version

#compile some example projects to warm up gradle and maven cache

WORKDIR /tmp
RUN git clone https://github.com/gradle/gradle-build-scan-quickstart.git
WORKDIR /tmp/gradle-build-scan-quickstart
RUN gradle --version
RUN gradle build -x test --info


# WORKDIR /tmp
# RUN git clone https://github.com/spring-projects/spring-framework.git
# WORKDIR /tmp/spring-framework
# RUN git checkout tags/v5.2.0.M2
# RUN gradle build -x test --info
# RUN rm -rf /tmp/spring-framework


# WORKDIR /tmp
# RUN git clone https://github.com/apache/kafka.git
# WORKDIR /tmp/kafka
# RUN git checkout tags/2.2.0
# RUN gradle build -x test --info
# RUN rm -rf /tmp/kafka
