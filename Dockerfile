# Use official OpenJDK 17 image
FROM openjdk:17

# Set working directory
WORKDIR /app

# Copy source code
COPY src ./src
COPY pom.xml .

# Install Maven inside container
RUN yum -y update && \
    yum -y install java-17-openjdk maven && \
    yum clean all

# Copy the built JAR to a standard name
RUN cp target/myjavaapp-1.0-SNAPSHOT.jar app.jar

# Expose port (optional)
EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
