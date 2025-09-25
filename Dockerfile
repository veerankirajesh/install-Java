# Stage 1: Build the JAR using Maven
FROM maven:3.9.0-eclipse-temurin-17 AS build

WORKDIR /app

# Copy Maven project files
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code and build
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime environment
FROM eclipse-temurin:17-jdk-slim

ARG APP_HOME=/app
ENV APP_HOME=$APP_HOME
WORKDIR $APP_HOME

# Copy built JAR from build stage
COPY --from=build /app/target/myjavaapp-1.0-SNAPSHOT.jar app.jar

# Expose port (optional)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
