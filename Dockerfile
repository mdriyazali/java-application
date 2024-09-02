# Use a base image with Maven to build the application
FROM maven:3.9.5 AS builder
ARG ENV=dev
ENV ENV=${ENV}
RUN echo ${ENV}

WORKDIR /usr/src/app

# Copy pom.xml and install dependencies (for Docker cache efficiency)
COPY pom.xml /usr/src/app/pom.xml
RUN mvn dependency:go-offline -B

# Copy the entire project
COPY . /usr/src/app

# Copy environment-specific configuration file
COPY conf/application-${ENV}.yml /usr/src/app/application.yml

# Build the application
RUN mvn clean install

# Create a new stage with OpenJDK
FROM openjdk:21-jdk
WORKDIR /app

# Copy built jar and configuration
COPY --from=builder /usr/src/app/target/*.jar app.jar
COPY --from=builder /usr/src/app/application.yml application.yml

# Run the application
CMD ["java", "-jar", "app.jar", "--spring.config.location=application.yml"]
