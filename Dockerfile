FROM fedora:38

# Instala las dependencias necesarias
RUN dnf -y update && \
    dnf -y install wget openssl systemd && \
    dnf clean all

RUN wget https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/RPMS/mongodb-org-server-7.0.4-1.el9.x86_64.rpm && \
    rpm -i mongodb-org-server-7.0.4-1.el9.x86_64.rpm && \
    rm mongodb-org-server-7.0.4-1.el9.x86_64.rpm

RUN sed -i "s|bindIp: 127.0.0.1|bindIp: 0.0.0.0 |g" /etc/mongod.conf

# Crea el directorio para almacenar los datos de MongoDB
RUN mkdir -p /data/db

EXPOSE 27017

# Configura el comando de inicio de MongoDB
CMD ["mongod", "--bind_ip", "0.0.0.0"]
