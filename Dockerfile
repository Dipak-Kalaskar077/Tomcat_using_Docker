# TOMCAT WITH JAVA BASE IMAGES
# Use a slim base image with Java pre-installed
FROM openjdk:11-jdk-slim

# Set environment variables for Tomcat
ENV CATALINA_HOME=/opt/apache-tomcat-9.0.97
ENV PATH=$CATALINA_HOME/bin:$PATH

# Install required dependencies and clean up
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Download and extract Tomcat
WORKDIR /opt
RUN curl -fSL https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.97/bin/apache-tomcat-9.0.97.tar.gz -o apache-tomcat-9.0.97.tar.gz && \
    tar -xzf apache-tomcat-9.0.97.tar.gz && \
    rm apache-tomcat-9.0.97.tar.gz

# Remove unnecessary directories to reduce image size
RUN rm -rf $CATALINA_HOME/webapps/examples $CATALINA_HOME/webapps/docs

# Expose Tomcat's HTTP port
EXPOSE 8080

# Start Tomcat in the foreground
CMD ["catalina.sh", "run"]
