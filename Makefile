##### Change the following for your environment:
NDK=/home/pan/software/android-ndk-r26b
TOOLCHAIN=$(NDK)/toolchains/llvm/prebuilt/linux-x86_64
API=23
SYSROOT=$(NDK)/toolchains/llvm/prebuilt/linux-x86_64/sysroot
CROSS_PREFIX=$(TOOLCHAIN)/bin/llvm-
DESTDIR=$(shell pwd)/../arm64-v8a

COMPILE_OPTS =         $(INCLUDES) -m64  -fPIC -fpic -I$(SYSROOT)/usr/local/include -I. -O2 -DSOCKLEN_T=socklen_t -D_LARGEFILE_SOURCE=1 -D_FILE_OFFSET_BITS=64 -DNO_OPENSSL=1 -DNO_GETIFADDRS=1 --sysroot=$(SYSROOT)
COMPILE_OPTS +=       -I/data/soft/build_librtmp/openssl-1.0.2j/_install/include
COMPILE_OPTS +=  -DNO_GETIFADDRS
# -DNO_OPENSSL=1 这个宏定义如果不配置，会默认使用ssl, 当前环境没有ssl库的情况下就会编译出错，所以屏蔽掉ssl依赖
# -DNO_GETIFADDRS=1 API 21的工具没有相关函数，所以屏蔽
C =                     c
#c ,指的是.c 文件扩展名，非c编译器
C_COMPILER =            $(TOOLCHAIN)/bin/aarch64-linux-android$(API)-clang
#C_COMPILER ,c文件编译器，使用clang
C_FLAGS =               $(COMPILE_OPTS)
CPP =                   cpp
#同样，cpp指的是 .cpp扩展名
CPLUSPLUS_COMPILER =    $(TOOLCHAIN)/bin/aarch64-linux-android$(API)-clang++
#c++ 编译器
CPLUSPLUS_FLAGS =       $(COMPILE_OPTS) -Wall -DBSD=1
OBJ =                   o
LINK =                  $(CPLUSPLUS_COMPILER) -o 
#LINK 编译可执行程序demo的命令，编译+连接 -o 后面加可执行程
LINK_OPTS =             -static-libstdc++
#编译连接可执行程序 的选项，对于android 这里 -static-libstdc++ 表示对c++库使用静态的连接，不然默认使用动态库，在设备上运行的时候会 dlopen c++.so erro。 
CONSOLE_LINK_OPTS =     $(LINK_OPTS)
LIBRARY_LINK =          $(CROSS_PREFIX)ar cr  
#制作库的命令， ar 命令， cr是参数。 
LIBRARY_LINK_OPTS =
LIB_SUFFIX =            a
#静态库 .a
LIBS_FOR_CONSOLE_APPLICATION =  
LIBS_FOR_GUI_APPLICATION =
EXE =
##### End of variables to change

LIVEMEDIA_DIR = liveMedia
GROUPSOCK_DIR = groupsock
USAGE_ENVIRONMENT_DIR = UsageEnvironment
BASIC_USAGE_ENVIRONMENT_DIR = BasicUsageEnvironment

TESTPROGS_DIR = testProgs

MEDIA_SERVER_DIR = mediaServer

PROXY_SERVER_DIR = proxyServer

HLS_PROXY_DIR = hlsProxy

all:
	cd $(LIVEMEDIA_DIR) ; $(MAKE)
	cd $(GROUPSOCK_DIR) ; $(MAKE)
	cd $(USAGE_ENVIRONMENT_DIR) ; $(MAKE)
	cd $(BASIC_USAGE_ENVIRONMENT_DIR) ; $(MAKE)
	cd $(TESTPROGS_DIR) ; $(MAKE)
	cd $(MEDIA_SERVER_DIR) ; $(MAKE)
	cd $(PROXY_SERVER_DIR) ; $(MAKE)
	cd $(HLS_PROXY_DIR) ; $(MAKE)
	@echo
	@echo "For more information about this source code (including your obligations under the LGPL), please see our FAQ at http://live555.com/liveMedia/faq.html"

install:
	cd $(LIVEMEDIA_DIR) ; $(MAKE) install
	cd $(GROUPSOCK_DIR) ; $(MAKE) install
	cd $(USAGE_ENVIRONMENT_DIR) ; $(MAKE) install
	cd $(BASIC_USAGE_ENVIRONMENT_DIR) ; $(MAKE) install
	cd $(TESTPROGS_DIR) ; $(MAKE) install
	cd $(MEDIA_SERVER_DIR) ; $(MAKE) install
	cd $(PROXY_SERVER_DIR) ; $(MAKE) install
	cd $(HLS_PROXY_DIR) ; $(MAKE) install

clean:
	cd $(LIVEMEDIA_DIR) ; $(MAKE) clean
	cd $(GROUPSOCK_DIR) ; $(MAKE) clean
	cd $(USAGE_ENVIRONMENT_DIR) ; $(MAKE) clean
	cd $(BASIC_USAGE_ENVIRONMENT_DIR) ; $(MAKE) clean
	cd $(TESTPROGS_DIR) ; $(MAKE) clean
	cd $(MEDIA_SERVER_DIR) ; $(MAKE) clean
	cd $(PROXY_SERVER_DIR) ; $(MAKE) clean
	cd $(HLS_PROXY_DIR) ; $(MAKE) clean

distclean: clean
	-rm -f $(LIVEMEDIA_DIR)/Makefile $(GROUPSOCK_DIR)/Makefile \
	  $(USAGE_ENVIRONMENT_DIR)/Makefile $(BASIC_USAGE_ENVIRONMENT_DIR)/Makefile \
	  $(TESTPROGS_DIR)/Makefile $(MEDIA_SERVER_DIR)/Makefile \
	  $(PROXY_SERVER_DIR)/Makefile \
	  $(HLS_PROXY_DIR)/Makefile \
	  Makefile
