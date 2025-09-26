# Use a Maven base image to build the application.
# OpenJDK 17 is used to support the Java version in your pom.xml.
FROM maven:3.9.6-openjdk-17 AS build

# Set the working directory inside the container.
WORKDIR /app

# Copy the project files into the container.
COPY . .

# Package the application as a layered JAR, skipping tests for a faster build.
RUN mvn clean package -DskipTests

# Use a lightweight JRE base image with OpenJDK 17 for the final image.
FROM openjdk:17-jre-slim

# Copy the final JAR from the build stage to the final image.
COPY --from=build /app/target/*.jar licensing-service.jar

# Expose the port on which the service will run.
EXPOSE 8080

# Define the default command to run the application.
ENTRYPOINT ["java", "-jar", "/licensing-service.jar"]