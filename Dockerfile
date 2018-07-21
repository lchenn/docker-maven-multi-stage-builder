FROM maven:3.5.3-jdk-8

COPY pom.xml /tmp/pom.xml
RUN mvn -f /tmp/pom.xml dependency:resolve-plugins dependency:resolve dependency:go-offline --batch-mode
