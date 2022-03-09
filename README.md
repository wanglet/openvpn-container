## server
1. 修改配置文件。

2. 配置ccd

3. 启动容器

   ```
   $ docker run -d --restart unless-stopped --privileged --name openvpn --net host -v /etc/openvpn/ccd/:/etc/openvpn/server/ccd/ -v /etc/openvpn/ipp.txt:/etc/openvpn/server/ipp.txt -v /etc/openvpn/pki/:/etc/openvpn/server/easy-rsa/pki/ -v /etc/openvpn/server.conf:/etc/openvpn/server/server.conf wanglet/openvpn:2.4.11 --port 22222 --config server.conf --suppress-timestamps --cipher AES-256-GCM --ncp-ciphers AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC:BF-CBC
   ```

## client
   ```
   $ docker run -d --restart unless-stopped --privileged --name openvpn-client --net host -v /etc/openvpn/client/:/etc/openvpn/client/ -v /etc/openvpn/client.conf:/etc/openvpn/server/client.conf wanglet/openvpn:2.4.11 --config client.conf --suppress-timestamps --cipher AES-256-GCM --ncp-ciphers AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC:BF-CBC
   ```

## forward
服务器客户端配置:

```
# 从openvpn.conf server字段配置的地址访问其它服务器的做snat
$ iptables -t nat  -A POSTROUTING -s 10.182.255.0/24 -o bond0 -j MASQUERADE
$ vim /etc/sysctl.conf
net.ipv4.ip_forward=1

$ sysctl -p
```

> 配置后笔记本客户端能直接访问服务器客户端的其它服务器。
