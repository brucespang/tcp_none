# tcp_none

A congestion control module for Linux that does not do congestion control. The intent is to set cwnd to some very large value (10,000) so that it no longer limits throughput, and then not update it in repsonse to acknowledgements or loss. 

This has been tested on kernel versions 5.11.0-41 and 5.5.0. I would _very much_ not recommend using it for production traffic without some other form of congestion control. If it seems useful to you, I would be fascinated to hear more about your use-case! Please email me and tell me about it!

## Building

```
$ make
make -C /lib/modules/`uname -r`/build M=`pwd`
make[1]: Entering directory '/usr/src/linux-headers-5.11.0-41-generic'
  CC [M]  /vagrant/tcp_none/tcp_none.o
  MODPOST /vagrant/tcp_none/Module.symvers
  CC [M]  /vagrant/tcp_none/tcp_none.mod.o
  LD [M]  /vagrant/tcp_none/tcp_none.ko
  BTF [M] /vagrant/tcp_none/tcp_none.ko
Skipping BTF generation for /vagrant/tcp_none/tcp_none.ko due to unavailability of vmlinux
make[1]: Leaving directory '/usr/src/linux-headers-5.11.0-41-generic'

$ sudo make install
rm -f /lib/modules/`uname -r`/tcp_none.ko
ln -s `pwd`/tcp_none.ko /lib/modules/`uname -r`
depmod -a
modprobe tcp_none

$ sysctl net.ipv4.tcp_available_congestion_control
net.ipv4.tcp_available_congestion_control = reno cubic none

$ sudo sysctl net.ipv4.tcp_congestion_control=none
net.ipv4.tcp_congestion_control = none
```