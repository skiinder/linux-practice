FROM centos:7
RUN useradd atguigu && \
    yum install -y epel-release && \
    yum install -y tini net-tools vim psmisc nc rsync lrzsz ntp libzstd openssl-static iotop && \
    yum clean all && \
    mkdir /opt/software /opt/module && \
    chown -R atguigu:atguigu /opt/software /opt/module

USER atguigu
WORKDIR /home/atguigu
