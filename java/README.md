

# Invocations

    mvn compile exec:java@MergeSort

# Embedded Tomcat with Log Config

    mvn clean compile exec:java@EmbeddedTomcat -Djava.util.logging.config.file=target/classes/logging.properties