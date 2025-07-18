# Use a base image with Maven and Java 17
# maven:3.9.6-eclipse-temurin-17 is a good choice for Maven 3.9.6 with Temurin JDK 17
FROM maven:3.9.6-eclipse-temurin-17 as build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files (pom.xml) first to leverage Docker cache
# This ensures that if only source code changes, Maven dependencies aren't re-downloaded every time
COPY pom.xml .
COPY src ./src

# Build the Spring Boot application
RUN mvn clean install -Dmaven.test.skip=true

# --- Second Stage: Create a smaller runtime image ---
# Use a JRE image for the final application to keep the image size small
FROM eclipse-temurin:17-jre-focal

# Set the working directory
WORKDIR /app

# Copy the built JAR from the build stage
# The JAR name should match your artifactId-version.jar from your pom.xml
COPY --from=build /app/target/task-manager-backend-0.0.1-SNAPSHOT.jar /app/app.jar

# Expose the port your Spring Boot app runs on (default 8080)
EXPOSE 8080

# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]