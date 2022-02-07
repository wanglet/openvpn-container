## server
1. 修改配置文件。

2. 配置ccd

3. 启动容器

   ```
   $ docker run -d --restart unless-stopped --privileged --name openvpn --net host -v /etc/openvpn/pki/:/etc/openvpn/server/easy-rsa/pki/ -v /etc/openvpn/server.conf:/etc/openvpn/server/server.conf wanglet/openvpn:2.4.11 --port 22222 --config server.conf --suppress-timestamps --cipher AES-256-GCM --ncp-ciphers AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC:BF-CBC
   ```

## client
   ```
   $ docker run -d --restart unless-stopped --privileged --name openvpn-client --net host -v /etc/openvpn/client/:/etc/openvpn/client/ -v /etc/openvpn/client.conf:/etc/openvpn/server/client.conf wanglet/openvpn:2.4.11 --config client.conf --suppress-timestamps --cipher AES-256-GCM --ncp-ciphers AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC:BF-CBC
   ```

## forward
笔记本客户端访问服务器客户端局域网内的其它机器时配置:

```
$ iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
$ vim /etc/sysctl.conf
net.ipv4.ip_forward=1

$ sysctl -p
```
