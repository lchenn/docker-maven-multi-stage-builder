# Maven docker multi-stage builder

Cache the maven dependencies used by maven, got the idea from [docker-maven#packaging-a-local-repository-with-the-image](https://github.com/carlossg/docker-maven#packaging-a-local-repository-with-the-image).

Use make use the cache, simply use this as 1st stage of the builder.


A sample Dockerfile with multi-stage building for a multi-module maven.
```
FROM lchenn/maven-multi-stage-builder:1.0.4 as build
WORKDIR /builder

COPY pom.xml .
COPY modue1 /builder/module1
COPY modue2 /builder/module2

RUN mvn  \
  --also-make \
  --update-snapshots \
  --batch-mode \
  --settings /usr/share/maven/ref/settings-docker.xml \
  --projects moduel1 \
  clean package
  
FROM openjdk:8-jre-alpine

RUN mkdir -p /opt/app
WORKDIR /opt/app

# Copy server jar.
COPY --from=build /builder/module1/target/*.jar /opt/app/
```
