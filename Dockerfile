FROM fedora:38

# Instala las dependencias necesarias
RUN dnf -y update && \
    dnf -y install wget openssl systemd && \
    dnf clean all

# Instalacion de mongo
RUN wget https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/RPMS/mongodb-org-server-7.0.4-1.el9.x86_64.rpm && \
    rpm -i mongodb-org-server-7.0.4-1.el9.x86_64.rpm && \
    rm mongodb-org-server-7.0.4-1.el9.x86_64.rpm

# configuracion adicional
COPY ./config/mongod.conf /conf/

EXPOSE 27020

# Configura el comando de inicio de MongoDB
CMD ["mongod", "--config", "/conf/mongod.conf"]
