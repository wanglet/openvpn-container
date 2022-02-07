FROM rockylinux:8

RUN yum -y install epel-release && \
    yum -y update && \
    yum install -y openssl lzo pam openssl-devel lzo-devel pam-devel && \
    yum install -y easy-rsa-3.0.8-1.el8 && \
    yum install -y openvpn-2.4.11-1.el8 && \
    yum clean all

RUN cp -rf /usr/share/easy-rsa/3.0.8/ /etc/openvpn/server/easy-rsa && \
    mkdir -p /var/log/openvpn/ && \
    chown openvpn:openvpn /var/log/openvpn && \
    mkdir -p /etc/openvpn/server/ccd && \
    mkdir -p /etc/openvpn/server/user
    #cd /etc/openvpn/server/easy-rsa && \
    #./easyrsa init-pki && \
    #./easyrsa build-ca nopass && \
    #./easyrsa build-server-full server nopass && \
    #./easyrsa build-client-full client1 nopass
    #./easyrsa gen-dh

WORKDIR /etc/openvpn/server/
ENTRYPOINT ["/usr/sbin/openvpn"]
