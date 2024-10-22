#!/bin/bash

# important: Update maven settings file with this file:
# https://git.onap.org/oparent/plain/settings.xml


# VES-COLLECTOR [1 container]
cd ves-collector
mvn clean package
cp ./src/docker/Dockerfile ./target/VESCollector-1.12.3-SNAPSHOT/
cd ./target/VESCollector-1.12.3-SNAPSHOT/
docker build -t sknrao/ves-collector:1.12.3 .
docker tag sknrao/ves-collector:1.12.3 ghcr.io/sknrao/ves-collector:1.12.3 

# DMAAP-MR
#git clone https://github.com/onap/archived-dmaap-messagerouter-messageservice dmaap-mr
#cd dmaap-mr
#git checkout tags/1.4.4
#mvn -Dmaven.skip.test=true clean install


# SDN Containers [2 containers]
cd sdnc-oam
mvn clean install -P docker -Ddocker.pull.registry=nexus3.onap.org:10001
docker tag onap/sdnc-image:2.6.1-SNAPSHOT-latest ghcr.io/sknrao/sdnc-image:2.6.1-SNAPSHOT-latest
docker push ghcr.io/sknrao/sdnc-image:2.6.1-SNAPSHOT-latest
docker tag onap/sdnc-web-image:2.6.1-SNAPSHOT-latest ghcr.io/sknrao/sdnc-web-image:2.6.1-SNAPSHOT-latest
docker push ghcr.io/sknrao/sdnc-web-image:2.6.1-SNAPSHOT-latest

# RANPM Containers [ 3 Containers]
cd ranpm/pmproducer
mvn clean install
mvn install docker:build
docker tag o-ran-sc/nonrtric-plt-pmproducer:latest ghcr.io/sknrao/nonrtric-plt-pmproducer:latest
docker push ghcr.io/sknrao/nonrtric-plt-pmproducer:latest
# repeat above 2 steps for 1.2.0-SNAPSHOT (instead of latest)
cd $home

cd ranpm/influxlogger
mvn clean install
mvn install docker:build
docker tag o-ran-sc/nonrtric-plt-pmlog:latest ghcr.io/sknrao/nonrtric-plt-pmlog:latest
docker push ghcr.io/sknrao/nonrtric-plt-pmlog:latest

cd ranpm/pm-file-converter
# We can tag to latest too
./build.sh ghcr.io/sknrao --tag 1.2.0
docker push ghcr.io/sknrao/pm-file-converter:1.2.0

# Other NON-RT-RIC basic containers [2 containers]
# CP and Gateway
cd cp-gw/nonrtric-gateway
mvn clean install
mvn install docker:build
docker tag o-ran-sc/nonrtric-gateway:latest ghcr.io/sknrao/nonrtric-gateway:latest
docker push ghcr.io/sknrao/nonrtric-gateway:latest

cd cp-gw/webapp-frontend
mvn clean install
mvn install docker:build
docker tag o-ran-sc/nonrtric-controlpanel:latest ghcr.io/sknrao/nonrtric-controlpanel:latest
docker push ghcr.io/sknrao/nonrtric-gateway:latest

# ICS [1 container]
cd ics
mvn clean install
mvn install docker:build
docker tag o-ran-sc/nonrtric-plt-informationcoordinatorservice:latest ghcr.io/sknrao/nonrtric-plt-informationcoordinatorservice:latest
docker push ghcr.io/sknrao/nonrtric-plt-informationcoordinatorservice:latest

# Authentication Token [1 container]
cd atoken/auth-token-fetch
docker build -t sknrao/nonrtric-plt-auth-token-fetch .
docker tag sknrao/nonrtric-plt-auth-token-fetch ghcr.io/sknrao/nonrtric-plt-auth-token-fetch
docker push ghcr.io/sknrao/nonrtric-plt-auth-token-fetch

