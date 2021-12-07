安装文件
-----

友情提示：<br />
如果是在Ubuntu 16.04上安装，请一定按照官方的编译说明来<br />
https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu <br />

<br />

1. 安装vmaf中间的坑 <br />
(1)提示未定义的引用"vmaf_cpu_cpuid"或者"vmaf_cpu_xgetbv" <br />
具体如下<br />
```
src/src@@libvmaf_cpu@sta/x86_cpu.c.o: In function `vmaf_get_cpu_flags_x86':
cpu.c:(.text+0x3d): undefined reference to `vmaf_cpu_cpuid'
cpu.c:(.text+0x7b): undefined reference to `vmaf_cpu_cpuid'
cpu.c:(.text+0xb2): undefined reference to `vmaf_cpu_xgetbv'
cpu.c:(.text+0xdc): undefined reference to `vmaf_cpu_cpuid'
collect2: error: ld returned 1 exit status
FAILED: cc  -o test/test_cpu 'test/test@@test_cpu@exe/test.c.o' 'test/test@@test_cpu@exe/test_cpu.c.o' 'src/src@@libvmaf_cpu@sta/cpu.c.o' 'src/src@@libvmaf_cpu@sta/x86_cpu.c.o' -Wl,--no-undefined -Wl,--as-needed -Wl,-O1  
src/src@@libvmaf_cpu@sta/x86_cpu.c.o: In function `vmaf_get_cpu_flags_x86':
cpu.c:(.text+0x3d): undefined reference to `vmaf_cpu_cpuid'
cpu.c:(.text+0x7b): undefined reference to `vmaf_cpu_cpuid'
cpu.c:(.text+0xb2): undefined reference to `vmaf_cpu_xgetbv'
cpu.c:(.text+0xdc): undefined reference to `vmaf_cpu_cpuid
```
解决方法：<br />
vmaf/libvmaf/src/meson.build文件<br />
给is_asm_enabled赋值为false <br />
(2)提示未定义的引用"pthread_create"和"pthread_detach"
```
FAILED: c++  -o test/test_context 'test/test@@test_context@exe/test.c.o' 'test/test@@test_context@exe/test_context.c.o' -Wl,--no-undefined -Wl,--as-needed -Wl,-O1 -Wl,--start-group src/libvmaf.a -lm -Wl,--end-group  
src/libvmaf.a(thread_pool.c.o): In function `vmaf_thread_pool_create':
thread_pool.c:(.text+0x1d3): undefined reference to `pthread_create'
thread_pool.c:(.text+0x1dc): undefined reference to `pthread_detach'
collect2: error: ld returned 1 exit status
FAILED: c++  -o tools/vmaf 'tools/tools@@vmaf@exe/vmaf.c.o' 'tools/tools@@vmaf@exe/cli_parse.c.o' 'tools/tools@@vmaf@exe/y4m_input.c.o' 'tools/tools@@vmaf@exe/vidinput.c.o' 'tools/tools@@vmaf@exe/yuv_input.c.o' -Wl,--no-undefined -Wl,--as-needed -Wl,-O1 -Wl,--start-group src/libvmaf.a -lm -Wl,--end-group  
src/libvmaf.a(thread_pool.c.o): In function `vmaf_thread_pool_create':
thread_pool.c:(.text+0x1d3): undefined reference to `pthread_create'
thread_pool.c:(.text+0x1dc): undefined reference to `pthread_detach'
collect2: error: ld returned 1 exit status
ninja: build stopped: subcommand failed.
```
打开vmaf/libvmaf/build/build.ninja文件<br />
查找--end-group，在src/libvmaf.a后面加上-pthread<br />
(3)执行ninja -vC build install时，前面一定要加上sudo！ <br />
(4)提示找不到.git什么仓库的时候，手动改一下.git地址，需要修改的文件是build.ninja

2. 安装libxcb的坑
可能缺少xcb-proto，提示版本必须要大于等于1.13<br />
安装方式如下 <br />
https://noknow.info/it/os/install_xcb_proto_from_source?lang=ja

3. 安装libaom的坑
按照 https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu 来了一遍，然后发现会提示让用-fpic重新编译，试了很多遍无果，
最后配置命令写成这样
```
export CXXFLAGS="$CXXFLAGS -fPIC" && PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_TESTS=OFF -DENABLE_NASM=on -DBUILD_SHARED_LIBS=1 ../aom
```
才编译通过的

4. 编译ffmpeg中间的坑
首先，ffmpeg最新版本的话，我们的程序跑不起来的，所以
```
PATH="$HOME/bin:$PATH" \ 
PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" \ 
./configure --prefix="$HOME/ffmpeg_build" --disable-debug \ 
--disable-doc \ 
--disable-ffplay \ 
--enable-shared \ 
--enable-avresample \ 
--enable-libopencore-amrnb \ 
--enable-libopencore-amrwb \ 
--enable-gpl \ 
--enable-gnutls \ 
--enable-libaom \ 
--enable-libass  \ 
--enable-libfdk-aac \
--enable-libfreetype \
--enable-libmp3lame \
--enable-libopus \ 
--enable-libvorbis \ 
--enable-libvpx \ 
--enable-libx264 \ 
--enable-libx265 \ 
--enable-nonfree \ 
--extra-cflags="-I$HOME/ffmpeg_build/include" \
--extra-ldflags="-L$HOME/ffmpeg_build/lib" \ 
--enable-libvmaf \ 
--enable-libsvtav1 \ 
--enable-libopus \ 
--extra-libs="-lpthread -lm -ldl -lnuma" \ 
--enable-version3 \ 
--ld="g++" \
```
5. 安装libx265
我在实际操作中发现apt安装libx265不太行，需要自己编译安装

6. 自己编译自己程序的时候，出现libavcodec.so: undefined reference to `swr_free@LIBSWRESAMPLE_2'
在/etc/ld.so.conf下面加一行 ffmpegbuild的目录/lib，然后sudo ldconfig<br />
https://blog.csdn.net/zz603976046/article/details/76572511
