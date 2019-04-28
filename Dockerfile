FROM ubuntu:19.04

ADD dependency/bin usr/local/bin
RUN apt-get update \
&& apt-get -f install -y make git wget python3

RUN chmod u+x /usr/local/bin/*

RUN cd /usr/local/bin \
&& wget http://opengene.org/fastp/fastp \
&& chmod a+x ./fastp

RUN mkdir /data

ENTRYPOINT ["/usr/local/bin/getopt.sh"] 