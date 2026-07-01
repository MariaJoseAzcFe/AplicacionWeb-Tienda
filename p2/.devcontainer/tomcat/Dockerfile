FROM tomcat:11.0-jdk21

RUN apt-get update && apt-get install -y \
    maven \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /practica2

EXPOSE 8080

CMD ["sleep", "infinity"]
