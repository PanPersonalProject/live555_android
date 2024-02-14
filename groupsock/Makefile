INCLUDES = -Iinclude -I../UsageEnvironment/include
PREFIX = /usr/local
LIBDIR = $(PREFIX)/lib
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

NAME = libgroupsock
ALL = $(NAME).$(LIB_SUFFIX)
all:	$(ALL)

.$(C).$(OBJ):
	$(C_COMPILER) -c $(C_FLAGS) $<
.$(CPP).$(OBJ):
	$(CPLUSPLUS_COMPILER) -c $(CPLUSPLUS_FLAGS) $<

GROUPSOCK_LIB_OBJS = GroupsockHelper.$(OBJ) GroupEId.$(OBJ) inet.$(OBJ) Groupsock.$(OBJ) NetInterface.$(OBJ) NetAddress.$(OBJ) IOHandlers.$(OBJ)

GroupsockHelper.$(CPP):	include/GroupsockHelper.hh
include/GroupsockHelper.hh:	include/NetAddress.hh
include/NetAddress.hh:	include/NetCommon.h
GroupEId.$(CPP):	include/GroupEId.hh
include/GroupEId.hh:	include/NetAddress.hh
inet.$(C):		include/NetCommon.h
Groupsock.$(CPP):	include/Groupsock.hh include/GroupsockHelper.hh
include/Groupsock.hh:	include/groupsock_version.hh include/NetInterface.hh include/GroupEId.hh
include/NetInterface.hh:	include/NetAddress.hh
NetInterface.$(CPP):	include/NetInterface.hh include/GroupsockHelper.hh
NetAddress.$(CPP):	include/NetAddress.hh include/GroupsockHelper.hh
IOHandlers.$(CPP):	include/IOHandlers.hh

libgroupsock.$(LIB_SUFFIX): $(GROUPSOCK_LIB_OBJS) \
    $(PLATFORM_SPECIFIC_LIB_OBJS)
	$(LIBRARY_LINK)$@ $(LIBRARY_LINK_OPTS) \
		$(GROUPSOCK_LIB_OBJS)

clean:
	-rm -rf *.$(OBJ) $(ALL) core *.core *~ include/*~

install: install1 $(INSTALL2)
install1: libgroupsock.$(LIB_SUFFIX)
	  install -d $(DESTDIR)$(PREFIX)/include/groupsock $(DESTDIR)$(LIBDIR)
	  install -m 644 include/*.hh include/*.h $(DESTDIR)$(PREFIX)/include/groupsock
	  install -m 644 libgroupsock.$(LIB_SUFFIX) $(DESTDIR)$(LIBDIR)
install_shared_libraries: libgroupsock.$(LIB_SUFFIX)
	  ln -fs libgroupsock.$(LIB_SUFFIX) $(DESTDIR)$(LIBDIR)/libgroupsock.$(SHORT_LIB_SUFFIX)
	  ln -fs libgroupsock.$(LIB_SUFFIX) $(DESTDIR)$(LIBDIR)/libgroupsock.so

##### Any additional, platform-specific rules come here:
