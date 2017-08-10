FROM artifactory.netent.com:5000/netent/noss-java-base:latest_int_test

RUN mkdir -p /app /app/bin /app/logs /log

ADD target/MCMService-1.0-SNAPSHOT.jar /app/bin
ADD config.yml                          /app/bin
RUN chmod -R 777 /app
RUN chmod -R 777 /log
USER 1001

EXPOSE 8080 8081 8089
CMD ["java", "-Xms64m", "-Xmx256m", \
    "-Xloggc:/app/logs/gc.log", "-XX:+UseGCLogFileRotation", "-XX:NumberOfGCLogFiles=7", \
    "-XX:GCLogFileSize=100M", "-XX:+HeapDumpOnOutOfMemoryError", "-XX:HeapDumpPath=/app/logs/", \
    "-Dcom.sun.management.jmxremote.port=8089", "-Dcom.sun.management.jmxremote.authenticate=false", \
    "-Dcom.sun.management.jmxremote.ssl=false", "-jar", "/app/bin/MCMService-1.0-SNAPSHOT.jar", \
    "server", "/app/bin/config.yml"]

