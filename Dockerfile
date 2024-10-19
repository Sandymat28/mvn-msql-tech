FROM openjdk:24-slim-bullseye

WORKDIR /app
COPY  . .
RUN mvn clean package

COPY target/*.jar /app/techstore.jar

ENTRYPOINT ["java", "-jar", "/app/techstore.jar"]
