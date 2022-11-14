FROM centos:7
RUN yum install -y epel-release && \
    yum install -y sudo tini net-tools vim psmisc nc rsync lrzsz ntp libzstd openssl-static && \
    yum clean all && \
    useradd atguigu && \
    usermod -aG wheel atguigu && \
    sed -i -e '/^\%wheel/s/^/#/' -e '/^# \%wheel/s/^# //' /etc/sudoers && \
    mkdir /opt/software /opt/module && \
    chown -R atguigu:atguigu /opt/software /opt/module

USER atguigu
WORKDIR /home/atguigu
