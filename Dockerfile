# Multi-stage build
# 1. stage: Maven imajı
FROM maven:3.8.6-amazoncorretto-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests

# 2. stage: Son imaj
FROM amazoncorretto:17-alpine-jdk
COPY --from=build /app/target/petclinic-0.0.1-SNAPSHOT.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]