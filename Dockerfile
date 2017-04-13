FROM ubuntu:12.04

LABEL Maintainer="Christian Witts <cwitts@gmail.com>"
LABEL Repo="https://github.com/ChristianWitts/wheel-builder"
LABEL DESCRIPTION="A Python wheel builder for your dependencies"

RUN apt-get update \
 && apt-get install -y \
        build-essential \
        gfortran \
        git \
        libblas-dev \
        libffi-dev \
        liblapack-dev \
        libssl-dev \
        libxml2-dev \
        libxslt1-dev \
        python \
        python-dev \
        unzip

WORKDIR /usr/src

ADD https://bootstrap.pypa.io/get-pip.py ./
RUN python ./get-pip.py

VOLUME /usr/src/target
WORKDIR /usr/src/target

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
