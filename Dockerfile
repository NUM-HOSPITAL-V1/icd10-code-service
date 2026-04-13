FROM maven:3.9.9-eclipse-temurin-21 AS builder
WORKDIR /app

COPY pom.xml ./
COPY src ./src

RUN mvn -q -DskipTests package

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

RUN apk add --no-cache curl

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8082

CMD ["java", "-jar", "/app/app.jar"]
