FROM maven:3.5.3-jdk-8

COPY pom.xml /tmp/pom.xml
RUN mvn \
  --settings /usr/share/maven/ref/settings-docker.xml \
  --file /tmp/pom.xml \
  --batch-mode \
  dependency:resolve-plugins \
  dependency:resolve \
  dependency:go-offline
