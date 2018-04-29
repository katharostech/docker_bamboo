################
# Bamboo image
################

# Set the base image
FROM registry.access.redhat.com/rhel7

# File Author / Maintainer
MAINTAINER Daniel Haws opax@kadima.solutions

# Build Args
ARG BAMBOO_VERSION
ARG DOWNLOAD_URL=https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${BAMBOO_VERSION}.tar.gz
ARG JDBC_DOWNLOAD_URL=https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.42.tar.gz

# Environment variables
# Variables not assigned values are required at run time
ENV BAMBOO_VERSION      $BAMBOO_VERSION
ENV BAMBOO_HOME         /app/bamboo_home
ENV BAMBOO_INSTALL_DIR  /opt/atlassian/bamboo
ENV JVM_MIN_MEM="1g"
ENV JVM_MAX_MEM="4g"
ENV JVM_REQUIRED_ARGS=""
ENV ssl_term_domain=""
ENV RUN_USER         bamboo
ENV RUN_GROUP        devops

# Update and install system dependencies

# Install Bamboo binaries
RUN \
groupadd ${RUN_GROUP} && \
useradd -g ${RUN_GROUP} ${RUN_USER}

RUN mkdir -p                             ${BAMBOO_INSTALL_DIR} \
    && curl -L --silent                  ${DOWNLOAD_URL} | tar -xz --strip-components=1 -C "${BAMBOO_INSTALL_DIR}" \
    && chmod -R 755 ${BAMBOO_INSTALL_DIR} \
    && chown -R ${RUN_USER}:${RUN_GROUP} ${BAMBOO_INSTALL_DIR}

# Install the JDBC driver
RUN curl -L --silent    ${JDBC_DOWNLOAD_URL} | tar -xz --strip-components=1 -C "${BAMBOO_INSTALL_DIR}/lib" mysql-connector-java*bin.jar && \
chmod 644 ${BAMBOO_INSTALL_DIR}/lib/mysql-connector-java*bin.jar

# Install JAVA
COPY java-cfg.sh /java-cfg.sh
RUN chmod 744 /java-cfg.sh
RUN /java-cfg.sh

# Create Bamboo home
RUN mkdir -p ${BAMBOO_HOME} \
    && chmod -R 755 ${BAMBOO_HOME} \
    && chown -R ${RUN_USER}:${RUN_GROUP} ${BAMBOO_HOME}

# Add the config and start scripts
COPY bamboo-init.properties ${BAMBOO_INSTALL_DIR}/atlassian-bamboo/WEB-INF/classes/
RUN chmod 644 ${BAMBOO_INSTALL_DIR}/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties

COPY docker-cmd.sh /docker-cmd.sh
RUN chmod 744 /docker-cmd.sh

COPY bamboo-cfg.sh /bamboo-cfg.sh
RUN chmod 744 /bamboo-cfg.sh

# Expose the Bamboo port
EXPOSE 8085
# Expose the JMS port
EXPOSE 54663

# Run this on container startup
CMD ["/docker-cmd.sh"]
