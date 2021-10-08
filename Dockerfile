FROM openjdk:11
WORKDIR /usr/src/app
COPY . .
EXPOSE 8080
CMD ./mvnw spring-boot:run
