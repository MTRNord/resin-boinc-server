FROM resin/armv7hf-debian-qemu

MAINTAINER MTRNord <info@nordgedanken.de>

RUN [ "cross-build-start" ]

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
RUN wget https://github.com/docker/compose/releases/download/1.7.1/docker-compose-Linux-x86_64 >> sudo /usr/local/bin/docker-compose && mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose


#configure server
RUN git clone https://github.com/marius311/boinc-server-docker.git && cd boinc-server-docker && cd ..
RUN echo "127.0.0.1 www.boincserver.com" >> /etc/hosts
COPY . /app

RUN [ "cross-build-end" ]

CMD ["bash", "cd boinc-server-docker && make up"]
