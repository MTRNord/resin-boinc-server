FROM resin/armv7hf-debian-qemu

MAINTAINER MTRNord <info@nordgedanken.de>

RUN [ "cross-build-start" ]

#install packages
RUN apt-get update && apt-get install -y \
        git \
        apt-transport-https \
        ca-certificates \
        make \
        build-essential \
        wget

# Install resin.io's rce (docker)
COPY ./rce /usr/bin/rce
RUN chmod u+x /usr/bin/rce
RUN ln -s /usr/bin/rce /usr/bin/docker

RUN apt-get update && apt-get install -y apt-transport-https && echo "deb https://packagecloud.io/Hypriot/Schatzkiste/debian/ jessie main" | tee /etc/apt/sources.list.d/hypriot.list && apt-get update && apt-get install -y --force-yes docker-compose

#configure server
RUN git clone https://github.com/MTRNord/boinc-server-docker.git && cd boinc-server-docker && make build && cd ..
RUN echo "127.0.0.1 www.boincserver.com" >> /etc/hosts
COPY . /app

RUN [ "cross-build-end" ]

CMD ["bash", "cd boinc-server-docker && make up"]
