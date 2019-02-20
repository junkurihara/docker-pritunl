FROM ubuntu:18.04

LABEL maintainer "Jun Kurihara <kurihara@ieee.org>"

WORKDIR /vpn

RUN apt-get update -q \
    && apt-get -y dist-upgrade \
    && apt-get install -y software-properties-common iptables \
    && apt-get -y clean \
    && apt -y autoremove

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A \    
    && add-apt-repository "deb http://repo.pritunl.com/stable/apt bionic main" \
    && apt-get update \
    && apt-get -y install pritunl \
    && apt-get -y clean \
    && apt -y autoremove

VOLUME /var/lib/pritunl

EXPOSE 443
EXPOSE 80

CMD ["/usr/bin/tail", "-f","/var/log/pritunl.log"]

