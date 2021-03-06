FROM python:3.6-stretch

MAINTAINER Ezra Kissel <ezkissel@indiana.edu>

EXPOSE 9001/tcp

RUN apt-get update
RUN apt-get -y install sudo cmake gcc libaprutil1-dev libapr1-dev python-setuptools python-pip supervisor

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/wdln && \
    echo "wdln:x:${uid}:${gid}:WILDFIRE-DLN,,,:/home/wdln:/bin/bash" >> /etc/passwd && \
    echo "wdln:x:${uid}:" >> /etc/group && \
    echo "wdln ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wdln && \
    chmod 0440 /etc/sudoers.d/wdln && \
    chown ${uid}:${gid} -R /home/wdln && \
    chown ${uid}:${gid} -R /opt

USER wdln
ENV HOME /home/wdln
WORKDIR $HOME

RUN git clone -b develop https://github.com/periscope-ps/unisrt
RUN git clone -b master https://github.com/datalogistics/wildfire-dln
RUN git clone -b develop https://github.com/datalogistics/libdlt
RUN git clone -b develop https://github.com/datalogistics/IDMS.git
ADD build.sh .
RUN bash ./build.sh

RUN mkdir $HOME/.periscope

ADD .dlt .
ADD .rtcache $HOME/.periscope/.rtcache/
RUN sudo chown wdln $HOME/.periscope/.rtcache 
ADD .cache $HOME/.periscope/.cache/
RUN sudo chown wdln $HOME/.periscope/.cache

ENV DEBUG INFO
ADD run.sh .
ADD idms.conf /etc/supervisor/conf.d/
CMD bash ./run.sh
