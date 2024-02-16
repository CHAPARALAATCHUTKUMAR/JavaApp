# Use an official Tomcat runtime as a parent image
FROM tomcat:9-jre8

# Set the working directory to /app
WORKDIR /app

# Copy the built artifact to the Tomcat webapps directory
COPY ../target/JavaApp-1.0-SNAPSHOT.jar /usr/local/tomcat/webapps/

# Expose the port that Tomcat will run on
EXPOSE 8080

# Define environment variable
ENV NAME World

# Run Tomcat
CMD ["catalina.sh", "run"]
