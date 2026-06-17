# ============================================
# ETAPE 1 : BUILD (compilation Maven)
# ============================================
FROM maven:3.9.6-eclipse-temurin-17-alpine AS builder
WORKDIR /app
# Copier le pom.xml et telecharger les dependances
COPY pom.xml .
RUN mvn dependency:go-offline -B
# Copier le code source et compiler
COPY src ./src
RUN mvn clean package -DskipTests -B
# ============================================
# ETAPE 2 : RUNTIME (image finale legere)
# ============================================
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Creer un utilisateur non-root
RUN addgroup -S devops && adduser -S devops -G devops
USER devops

# Copier le JAR depuis l'etape de build
COPY --from=builder /app/target/*.jar app.jar

# Exposer le port
EXPOSE 8080

# Commande de demarrage
ENTRYPOINT ["java", "-jar", "app.jar"]