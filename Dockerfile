FROM maven:3.9.4-eclipse-temurin-17

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src

# Build the JAR
RUN mvn clean package -DskipTests

# Copy built JAR to standard name
RUN cp target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
