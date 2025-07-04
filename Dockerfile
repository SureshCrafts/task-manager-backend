# Use a base image with Java 17 and Maven
# eclipse-temurin is a good choice for official OpenJDK builds
FROM eclipse-temurin:17-jdk-focal as build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files (pom.xml) first to leverage Docker cache
# This ensures that if only source code changes, Maven dependencies aren't re-downloaded every time
COPY pom.xml .
COPY src ./src

# Build the Spring Boot application
# -Dmaven.test.skip=true is added to skip tests during build, which can speed up deployment.
# You can remove it if you want tests to run during every Render build.
RUN mvn clean install -Dmaven.test.skip=true

# --- Second Stage: Create a smaller runtime image ---
FROM eclipse-temurin:17-jre-focal

# Set the working directory
WORKDIR /app

# Copy the built JAR from the build stage
# The JAR name should match your artifactId-version.jar from your pom.xml
# For example, if your pom.xml artifactId is 'task-manager-backend' and version is '0.0.1-SNAPSHOT'
# then the JAR will be 'task-manager-backend-0.0.1-SNAPSHOT.jar'
COPY --from=build /app/target/task-manager-backend-0.0.1-SNAPSHOT.jar /app/app.jar

# Expose the port your Spring Boot app runs on (default 8080)
EXPOSE 8080

# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]