## https://github.com/michaelmiklis/docker-rpi-monitor
## https://github.com/ikaritw/docker-rpi-monitor
#FROM resin/rpi-raspbian:latest
#FROM balenalib/rpi-raspbian:latest
FROM ikaritw/raspbian:buster

#LABEL maintainer="Michael Miklis / <info@michaelmiklis.de>"
LABEL maintainer="ikaritw / <ikaritw+docker@gmail.com>"

#RUN [ "cross-build-start" ]

ENV  DEBIAN_FRONTEND noninteractive

# Allow access to port 8888
EXPOSE 8888

# Start rpimonitord using run.sh wrapper script
ADD run.sh /run.sh
RUN chmod +x /run.sh
CMD bash -C '/run.sh';'bash'

# Install RPI-Monitor form Xavier Berger's repository
RUN true && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get -y update && \
    apt-get install -y --no-install-recommends dirmngr apt-transport-https ca-certificates apt-utils libraspberrypi-bin wget

## install with APT
#RUN wget http://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list && apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F && apt-get -y -qq update && apt-get install -y -qq rpimonitor

## Custom installation: Installation from Debian package
RUN true && \
    wget https://goo.gl/yDYFhy -O /tmp/rpimonitor_latest.deb && \
    #apt-get install -y librrds-perl libhttp-daemon-perl libjson-perl libipc-sharelite-perl libfile-which-perl libsnmp-extension-passpersist-perl aptitude && \
    #dpkg -i rpimonitor_latest.deb && \
    apt-get install -f -y --no-install-recommends /tmp/rpimonitor_latest.deb && \
    /usr/share/rpimonitor/scripts/updatePackagesStatus.pl

## Clear
RUN true && \
    apt-get remove -y wget apt-utils && \
    apt-get autoremove --purge -y && \
    apt-get clean -y && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sed -i 's/\/sys\//\/dockerhost\/sys\//g' /etc/rpimonitor/template/* && \
    sed -i 's/\/etc\/os-release/\/dockerhost\/usr\/lib\/os-release/g' /etc/rpimonitor/template/version.conf && \
    sed -i 's/\/proc\//\/dockerhost\/proc\//g' /etc/rpimonitor/template/* && \
    echo include=/etc/rpimonitor/template/wlan.conf >> /etc/rpimonitor/data.conf && \
    sed -i '/^web.status.1.content.8.line/ d' /etc/rpimonitor/template/network.conf && \
    sed -i '/^#web.status.1.content.8.line/s/^#//g' /etc/rpimonitor/template/network.conf && \
    sed -i 's/\#dynamic/dynamic/g' /etc/rpimonitor/template/network.conf && \
    sed -i 's/\#web.statistics/web.statistics/g' /etc/rpimonitor/template/network.conf

LABEL version="RPI-Monitor:2.13"

#RUN [ "cross-build-end" ]

