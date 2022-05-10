FROM ubuntu:20.04

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN apt update && apt install -y wget

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-4.3.11-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-4.3.11-Linux-x86_64.sh -b \
    && rm -f Miniconda3-4.3.11-Linux-x86_64.sh 

RUN apt-get update -y && apt-get install -y bc

RUN apt-get install -y unzip 
RUN apt-get install -y bzip2
RUN apt-get install -y xz-utils 
RUN apt-get install -y zstd
RUN apt-get install -y gzip

RUN apt-get install -y gcc-multilib

RUN apt-get install -y build-essential

RUN apt-get install -y clang

RUN apt-get install -y git

RUN conda install anaconda-client --yes

RUN conda install -c bioconda libgcc --yes

ADD . /compact 

WORKDIR /compact

RUN chmod +x ./*sh

CMD tail -f >> /dev/null