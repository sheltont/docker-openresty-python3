FROM openresty/openresty:centos
MAINTAINER Shelton Tang <xiaodong.tang@binqsoft.com>

# Install redis
RUN yum install -y epel-release
RUN yum update -y
RUN yum install -y redis

# Install a default redis conf
ADD redis.conf /etc/redis/

# Install python 3.6.1
ENV PYTHON_VERSION "3.6.1"
RUN yum install -y \
    wget \
    gcc make \
    zlib-dev openssl-devel sqlite-devel bzip2-devel

RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar xvf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --prefix=/usr/local \
    && make \
    && make altinstall \
    && cd / \
    && rm -rf Python-${PYTHON_VERSION}*

 

CMD ["/usr/bin/openresty", "-g", "daemon off;"]
