# Use CentOS 8 as base
FROM centos:8

# Set working directory
WORKDIR /app

# Install Java 17 and Maven
RUN dnf -y update && \
    dnf -y install java-17-openjdk maven && \
    dnf clean all
# Copy source code
COPY src ./src
COPY pom.xml .

# Build the JAR
RUN mvn clean package -DskipTests

# Copy built JAR to standard name
RUN cp target/myjavaapp-1.0-SNAPSHOT.jar app.jar

# Expose port
EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
