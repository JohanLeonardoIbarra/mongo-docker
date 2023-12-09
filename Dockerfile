FROM debian:bullseye-slim

# Instala las dependencias necesarias
RUN apt-get update && \
    apt-get install -y \
    gnupg wget && \
    rm -rf /var/lib/apt/lists/*

# Importa la clave pública de MongoDB
RUN wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | gpg --import -

# Añade la clave GPG del repositorio de MongoDB al sistema
RUN gpg --export --armor B00A0BD1E2C63C11 | apt-key add -

# Añade el repositorio de MongoDB
RUN echo "deb http://repo.mongodb.org/apt/debian bullseye/mongodb-org/5.0 main" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list

# Instala MongoDB
RUN apt-get update && \
    apt-get install -y mongodb-org && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i "s|bindIp: 127.0.0.1|bindIp: 0.0.0.0 |g" /etc/mongod.conf

# Configura el servicio de MongoDB
VOLUME /data/db
EXPOSE 27017

# Inicia MongoDB con el comando mongod
CMD ["mongod"]

