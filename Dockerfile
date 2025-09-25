# Use OpenJDK 17 slim
FROM openjdk:17-jdk-slim

# Build-time and runtime variable
ARG APP_HOME=/app
ENV APP_HOME=$APP_HOME

# Set working directory
WORKDIR $APP_HOME

# Add your application JAR
ADD MyApp.jar $APP_HOME/MyApp.jar

# Create non-root user and set permissions
RUN useradd -m appuser && chown -R appuser:appuser $APP_HOME
USER appuser

# Expose application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "MyApp.jar"]
