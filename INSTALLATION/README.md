安装文件
-----
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
