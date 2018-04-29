#!/bin/bash

# Determine which JAVA to use
if [ ${BAMBOO_VERSION} = "5.4.2" ]
then
    yum install -y java-1.7.0 && yum clean all && \
    echo "/etc/alternatives/jre_1.7.0_openjdk" > /java_home.txt
else
    yum install -y java-1.8.0 && yum clean all && \
    echo "/etc/alternatives/jre_1.8.0_openjdk" > /java_home.txt
fi
