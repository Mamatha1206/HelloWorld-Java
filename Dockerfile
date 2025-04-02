FROM openjdk:17-alpine

WORKDIR /app

COPY . /app/

# Create a directory for libraries
RUN mkdir -p /app/libs && \
    wget -q -O /app/libs/javax.servlet-api.jar https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar && \
    wget -q -O /app/libs/jetty-server.jar https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-server/9.4.44.v20210927/jetty-server-9.4.44.v20210927.jar && \
    wget -q -O /app/libs/jetty-servlet.jar https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-servlet/9.4.44.v20210927/jetty-servlet-9.4.44.v20210927.jar && \
    wget -q -O /app/libs/jetty-util.jar https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-util/9.4.44.v20210927/jetty-util-9.4.44.v20210927.jar && \
    wget -q -O /app/libs/jetty-util-ajax.jar https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-util-ajax/9.4.44.v20210927/jetty-util-ajax-9.4.44.v20210927.jar

# Compile Java Application
RUN javac -cp "/app/libs/*" HelloWorld.java

CMD ["java", "-cp", "/app/libs/*:.", "HelloWorld"]

