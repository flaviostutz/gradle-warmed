FROM openjdk:8-jdk-stretch AS BUILD

WORKDIR /tmp
RUN wget https://services.gradle.org/distributions/gradle-5.5.1-bin.zip -P /tmp
RUN unzip -d /opt/gradle /tmp/gradle-*.zip
ENV GRADLE_HOME=/opt/gradle/gradle-5.5.1
RUN ln -s $GRADLE_HOME/bin/gradle /usr/bin/gradle

RUN gradle -v

#compile some example projects to warm up gradle and maven cache

WORKDIR /tmp
RUN git clone https://github.com/gradle/gradle-build-scan-quickstart.git
WORKDIR /tmp/gradle-build-scan-quickstart
RUN gradle build -x test --info

WORKDIR /tmp
RUN git clone https://github.com/Netflix/conductor.git
WORKDIR /tmp/conductor
RUN git checkout tags/v2.14.1
RUN ./gradlew -x test --build-cache --no-daemon
# RUN gradle build --info --no-daemon -x test

WORKDIR /
RUN rm -rf /tmp/*

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
