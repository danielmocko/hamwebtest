FROM maven:3.8.1-openjdk-11-slim as build
WORKDIR /app
COPY src src
COPY pom.xml .
RUN mvn clean package -DskipTests

FROM openjdk:11.0.11-jdk-slim as image
COPY --from=build app/target/*.jar hamwebtest.jar
ENTRYPOINT [ "sh", "-c", "java -jar hamwebtest.jar" ]