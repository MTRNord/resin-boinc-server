FROM armv7/armhf-ubuntu:16.04

MAINTAINER MTRNord <info@nordgedanken.de>

#install packages 
RUN apt-get update && apt-get install -y \
        git \
        apt-transport-https \
        ca-certificates \
        make \
        build-essentials
        
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" >> /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install linux-image-extra-$(uname -r) && apt-get update &&  apt-get install docker-engine && service docker start

#configure server
RUN git clone https://github.com/marius311/boinc-server-docker.git && cd boinc-server-docker && cd ..
RUN echo "127.0.0.1 www.boincserver.com" >> /etc/hosts
COPY . /app


CMD ["bash", "cd boinc-server-docker && make up"]
