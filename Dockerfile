FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre

WORKDIR /app

<<<<<<< HEAD
COPY --from=build /app/target/*.jar app.jar
=======
COPY --from=build /app/target/DevOps-Lab-1.0-SNAPSHOT.jar app.jar
>>>>>>> ba92d0f (changes jenkinsfile)

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
