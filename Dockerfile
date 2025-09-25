# Use OpenJDK base image
FROM openjdk:17-jdk-slim

# ARG → build-time variable
ARG APP_HOME=/app

# ENV → runtime environment variable
ENV APP_HOME=$APP_HOME

# WORKDIR → set working directory
WORKDIR $APP_HOME

# ADD → add JAR file (example)
ADD MyApp.jar $APP_HOME/MyApp.jar

# COPY → copy config file (if any)
COPY subfolder/config.yaml $APP_HOME/config.yaml

# USER → create and switch to non-root user
RUN useradd -m appuser
USER appuser

# EXPOSE → open port
EXPOSE 8080

# CMD → default command
CMD ["java", "-jar", "MyApp.jar"]

# ENTRYPOINT → fixed executable
ENTRYPOINT ["java", "-jar", "MyApp.jar"]
