FROM ubuntu:12.04
MAINTAINER Amara "http://amara.org"
RUN (echo "deb http://archive.ubuntu.com/ubuntu precise main universe multiverse" > /etc/apt/sources.list)
RUN (echo "deb-src http://archive.ubuntu.com/ubuntu precise main universe multiverse" >> /etc/apt/sources.list)
RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN RUNLEVEL=1 DEBIAN_FRONTEND=noninteractive apt-get install -y wget erlang-nox logrotate
RUN wget https://s3.amazonaws.com/amara/support/rabbitmq-server_3.1.5-1_all.deb --no-check-certificate -O /tmp/rabbitmq.deb
RUN RUNLEVEL=1 dpkg -i /tmp/rabbitmq.deb
RUN rabbitmq-plugins enable rabbitmq_management

EXPOSE 5672
EXPOSE 15672

CMD ["/usr/sbin/rabbitmq-server"]
