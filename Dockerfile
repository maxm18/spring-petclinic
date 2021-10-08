FROM openjdk:11
WORKDIR /usr/src/app
COPY . .
EXPOSE 8080
CMD java -jar target/*.jar
