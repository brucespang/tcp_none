all: tcp_none.ko

clean:
	rm -f tcp_none.ko tcp_none.o modules.order Module.symvers tcp_none.mod tcp_none.mod.*

tcp_none.ko:
	make -C /lib/modules/`uname -r`/build M=`pwd`
	
install: tcp_none.ko
	rm -f /lib/modules/`uname -r`/tcp_none.ko
	ln -s `pwd`/tcp_none.ko /lib/modules/`uname -r`
	depmod -a
	modprobe tcp_none