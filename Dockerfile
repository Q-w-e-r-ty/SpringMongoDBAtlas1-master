# ---- build stage ----
FROM maven:3.9.6-eclipse-temurin-21 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# ---- run stage ----
FROM eclipse-temurin:21-jre
WORKDIR /
# copy the jar built in the previous stage
COPY --from=builder /app/target/SpringMongoDBAtlas1-0.0.1-SNAPSHOT.jar /app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
