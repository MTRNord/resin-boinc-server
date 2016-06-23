FROM resin/armv7hf-debian-qemu

MAINTAINER MTRNord <info@nordgedanken.de>

RUN [ "cross-build-start" ]

#install packages
RUN apt-get update && apt-get install -y \
        git \
        apt-transport-https \
        ca-certificates \
        make \
        build-essential

# Install resin.io's rce (docker)
COPY ./rce /usr/bin/rce
RUN chmod u+x /usr/bin/rce
RUN ln -s /usr/bin/rce /usr/bin/docker

RUN service docker start
RUN wget https://github.com/docker/compose/releases/download/1.7.1/docker-compose-Linux-x86_64 >> sudo /usr/local/bin/docker-compose && mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose


#configure server
RUN git clone https://github.com/marius311/boinc-server-docker.git && cd boinc-server-docker && cd ..
RUN echo "127.0.0.1 www.boincserver.com" >> /etc/hosts
COPY . /app

RUN [ "cross-build-end" ]

CMD ["bash", "cd boinc-server-docker && make up"]
