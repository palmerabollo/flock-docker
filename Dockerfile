FROM 		dockerfile/nodejs
MAINTAINER 	Guido García <palmerabollo@gmail.com>

ADD https://dl.bintray.com/mitchellh/consul/0.4.1_linux_amd64.zip /tmp/consul.zip
RUN cd /usr/local/bin && unzip /tmp/consul.zip && chmod +x /usr/local/bin/consul && rm /tmp/consul.zip

RUN cd /tmp && wget https://github.com/hashicorp/envconsul/releases/download/v0.3.0/envconsul_0.3.0_linux_amd64.tar.gz
RUN cd /tmp && tar xfz envconsul_0.3.0_linux_amd64.tar.gz
RUN mv /tmp/envconsul_0.3.0_linux_amd64/envconsul /usr/local/bin && chmod +x /usr/local/bin/envconsul && rm -rf /tmp/envconsul*

ADD https://dl.bintray.com/mitchellh/consul/0.4.1_web_ui.zip /tmp/webui.zip
RUN cd /tmp && unzip /tmp/webui.zip && mv dist /ui && rm /tmp/webui.zip

# ADD https://get.docker.io/builds/Linux/x86_64/docker-1.2.0 /bin/docker
# RUN chmod +x /bin/docker

# RUN apt-get install -y curl

RUN mkdir /etc/consul.d
ADD ./config/consul.json /etc/consul.conf
# ONBUILD ADD ./config /config/

ADD ./start /usr/local/bin/start
RUN chmod +x /usr/local/bin/start

# ADD ./check-http /bin/check-http
# ADD ./check-cmd /bin/check-cmd

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53/udp
# VOLUME ["/data"]

ENV SHELL /bin/bash

ENTRYPOINT ["/usr/local/bin/start"]
CMD []
