# Use a minimal OpenJDK 17 image as the base
FROM openjdk:17-jdk-slim

# Set working directory inside the container
WORKDIR /app

# Copy the JAR file into the container
COPY target/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose port 8080
EXPOSE 8080
# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
