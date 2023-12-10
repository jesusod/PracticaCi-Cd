# Utilizar una imagen base con OpenJDK 11
FROM openjdk:11-jdk

# Instalar Maven
RUN apt-get update && apt-get install -y maven

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar el archivo pom.xml y el código fuente
COPY pom.xml .
COPY src ./src

# Compilar la aplicación y omitir las pruebas
# Nota: Asumo que deseas omitir las pruebas aquí; si no, quita '-DskipTests'
RUN mvn clean install -DskipTests

# Empaquetar la aplicación sin ejecutar las pruebas, las pruebas ya se han ejecutado en CircleCI
RUN mvn package -Dmaven.test.skip=true

# Exponer el puerto que utiliza tu aplicación si es necesario
# Por ejemplo, si tu aplicación usa el puerto 8080, descomenta la siguiente línea
EXPOSE 8080

# Especificar el comando para ejecutar la aplicación
# Ajusta 'tu-artifactId' y 'tu-version' según el nombre y la versión de tu archivo jar
CMD ["java", "-jar", "target/practicaci-cd-1.0-SNAPSHOT.jar"]