# Use OpenJDK base image
FROM openjdk:17-alpine

# Set working directory inside the container
WORKDIR /app

# Copy the Java source files
COPY . /app/

# Install Jetty server dependency
RUN mkdir -p /app/libs && \
    wget -q -O /app/libs/jetty-servlet.jar https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-servlet/9.4.44.v20210927/jetty-servlet-9.4.44.v20210927.jar && \
    wget -q -O /app/libs/jetty-server.jar https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-server/9.4.44.v20210927/jetty-server-9.4.44.v20210927.jar

# Compile Java program
RUN javac -cp "/app/libs/*" HelloWorld.java

# Define the entry point
CMD ["java", "-cp", ".:/app/libs/*", "HelloWorld"]
