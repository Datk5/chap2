# Sử dụng Maven để build project
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Dùng Tomcat để chạy file .war
FROM tomcat:9.0-jdk17-temurin
# Xóa app mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy file WAR build từ Maven sang Tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
