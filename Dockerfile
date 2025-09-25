# Stage 1: Build the app
FROM maven:3.9.0-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom.xml and download dependencies first (cache optimization)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code and build
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:17-jdk-slim

ARG APP_HOME=/app
ENV APP_HOME=$APP_HOME
WORKDIR $APP_HOME

# Copy built jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Copy config if any
COPY config.yaml $APP_HOME/config.yaml

# Create non-root user
RUN useradd -m appuser && chown -R appuser:appuser $APP_HOME
USER appuser

# Expose port
EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
