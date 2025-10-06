# 基于 python:3.12.2-slim-bullseye 镜像  
FROM python:slim-trixie

# RUN mkdir -p /root/.ssh
# COPY authorized_keys /root/.ssh/authorized_keys

ADD . /application
WORKDIR /application

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources

RUN apt-get update 

RUN apt-get install procps openssh-server libpq-dev -y

RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
ADD https://github.com/ta-lib/ta-lib/releases/download/v0.6.4/ta-lib_0.6.4_amd64.deb /tmp/

RUN dpkg -i /tmp/ta-lib_0.6.4_amd64.deb

# RUN pip install --upgrade pip 
# 安装talib底层包
# RUN bash talib.sh
# # RUN pip install -r requirements.txt
RUN apt-get purge  -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

EXPOSE 5000
VOLUME /application
CMD bash ./web.sh
