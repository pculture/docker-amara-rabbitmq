FROM ubuntu:14.04
MAINTAINER Amara "http://amara.org"
RUN (echo "deb http://archive.ubuntu.com/ubuntu trusty main universe multiverse" > /etc/apt/sources.list)
RUN (echo "deb-src http://archive.ubuntu.com/ubuntu trusty main universe multiverse" >> /etc/apt/sources.list)
RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
ENV RUNLEVEL 1
RUN apt-get install -y wget erlang-nox
RUN wget https://s3.amazonaws.com/amara/support/rabbitmq-server_3.1.5-1_all.deb --no-check-certificate -O /tmp/rabbitmq.deb
RUN dpkg -i /tmp/rabbitmq.deb
RUN apt-get -fy install
RUN rabbitmq-plugins enable rabbitmq_management
RUN yes | LICENSE_KEY=4f43cb7da418b40b2b2d2c7e97f0d827a4a8b8e1 bash -c "$(curl -sSL https://download.newrelic.com/npi/release/install-npi-linux-debian-x64.sh)"
RUN cd newrelic-npi/
#RUN ./npi install 

EXPOSE 5672
EXPOSE 15672

CMD ["/usr/sbin/rabbitmq-server"]
