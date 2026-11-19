# Transportes Feli

Aplicación de gestión de cargas y transporte desarrollada en Java + JavaFX para gestionar la operación entre conductores, gestores y administración.

## Descripción general

La aplicación permite:

- gestionar conductores, vehículos y empresas,
- crear y administrar cargas y entregas,
- reservar cargas desde la visión del conductor,
- validar compatibilidades técnicas y geográficas,
- generar informes y documentos asociados a los envíos,
- controlar la operación desde una base de datos relacional.

El sistema está pensado como una bolsa de transporte en la que cada rol tiene una entrada distinta:

- Conductor: consulta cargas disponibles, filtra según criterios y reserva la asignación.
- Gestor: crea y administra cargas y entregas.
- Administrador: supervisa la base de datos y la configuración global del sistema.

## Roles del sistema

### 1. Administrador

- gestiona la configuración global,
- controla datos maestros de la base de datos,
- supervisa el funcionamiento del sistema y sus registros.

### 2. Gestor

- crea y mantiene cargas y entregas,
- organiza las operaciones logísticas,
- define los datos asociados a la oferta de transporte.

### 3. Conductor

- accede al sistema con credenciales propias,
- visualiza cargas compatibles,
- selecciona una carga y confirma la reserva,
- queda asociado a un vehículo para la operación del envío.

## Funcionalidades principales

- autenticación por roles,
- gestión de usuarios y perfiles,
- gestión de vehículos y conductores,
- gestión de empresas,
- gestión de cargas, entregas y destinos,
- validación por tipo de vehículo, carga útil, tipos de bulto, ADR/ATP, etc.,
- reserva de carga por conductores,
- generación de informes PDF del envío,
- soporte de datos iniciales para entorno de pruebas.

## Tecnologías

- Java 21
- JavaFX
- Maven
- MariaDB
- PDFBox
- JasperReports / informes
- MaterialFX, JFoenix, BootstrapFX
- PlantUML para documentación técnica

## Estructura del proyecto

```text
.
├── src/
│   └── main/
│       ├── java/
│       │   └── es/israeldelamo/transportes/
│       │       ├── controladores/
│       │       ├── dao/
│       │       ├── modelos/
│       │       ├── utilidades/
│       │       └── ...
│       └── resources/
├── README.md
├── pom.xml
├── datos_incialización.sql
├── diagrama-dominio-transporte.puml
├── diagrama-casos-uso-transporte.puml
├── diagrama-secuencia-reservar-carga-conductor.puml
└── ...
```

## Documentación visual

El proyecto incluye diagramas en formato PlantUML para facilitar la comprensión del dominio y de los flujos principales:

- [diagrama-dominio-transporte.puml](diagrama-dominio-transporte.puml)
- [diagrama-casos-uso-transporte.puml](diagrama-casos-uso-transporte.puml)
- [diagrama-secuencia-reservar-carga-conductor.puml](diagrama-secuencia-reservar-carga-conductor.puml)

Estos diagramas permiten documentar:

- el dominio de negocio,
- los actores y casos de uso,
- la secuencia de reserva de carga por conductor.

## Base de datos y datos iniciales

El repositorio incluye SQL de inicialización con datos base para entorno de pruebas, como:

- países,
- provincias,
- localidades,
- códigos postales,
- usuario base del sistema,
- empresa base de ejemplo.

Archivos relevantes:

- [datos_incialización.sql](datos_incialización.sql)

## Requisitos

Para ejecutar el proyecto necesitas:

- Java 21 o superior
- Maven
- Base de datos MariaDB configurada
- entorno gráfico compatible con JavaFX

## Ejecución

Desde la raíz del proyecto:

```bash
./mvnw clean package
java -jar target/transportes-2.beta.jar
```

Si se usa Maven sin wrapper:

```bash
mvn clean package
java -jar target/transportes-2.beta.jar
```

## Dockerización

La aplicación también se puede ejecutar en contenedor, aunque la interfaz JavaFX requiere acceso a X11 o equivalente.

### Dockerfile de ejemplo

```dockerfile
FROM ubuntu:20.04
ENV TZ=Asia/Kolkata \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y
RUN apt-get install -y gnupg ca-certificates curl
RUN curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list
RUN apt update -y
RUN apt install zulu23-ca-jdk -y
RUN apt install maven -y
RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y \
    libxss1 \
    libx11-6 \
    libxext6 \
    libxi6 \
    libxrender1 \
    libxrandr2 \
    libxxf86vm1 \
    libglu1-mesa \
    libfontconfig1 \
    libgdk-pixbuf2.0-0 \
    libgtk-3-0 \
    libgl1-mesa-glx

RUN git clone https://github.com/israel05/transporteBeta1.git

WORKDIR /transporteBeta1
RUN mvn package

CMD java -jar /transporteBeta1/target/transportes-1.beta.jar
```

### Construcción del contenedor

```bash
docker build --tag transportes .
```

### Ejecución con X11 en Windows

Requisitos:

- VcXsrv instalado
- xLaunch ejecutándose
- opción "Disable access control" desmarcada

```bash
docker run -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix transportes
```

## Ideas de evolución (V2)

Se plantean mejoras futuras como:

- alertas automáticas cuando un conductor busca una carga que no existe,
- geocodificación por nombre de calle para obtener el código postal,
- mejoras en la búsqueda y filtrado de cargas,
- ampliación de notificaciones y automatización operativa,
- refinamiento de la capa de validación de la lógica de negocio.

## Notas

Este repositorio combina la parte funcional (JavaFX + base de datos) con documentación de dominio y casos de uso, facilitando la comprensión del sistema para mantenimiento, evolución y presentación interna.

## Licencia

El proyecto no incluye una licencia explícita en este repositorio. Si se va a reutilizar o distribuir, conviene aclararla antes de hacerlo en producción.

