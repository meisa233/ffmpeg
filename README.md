# ffmpeg安装
```
sudo apt install autoconf automake cmake curl bzip2 libexpat1-dev g++ gcc git gperf libtool make meson nasm perl pkg-config python libssl-dev yasm zlib1g-dev
sudo apt install libaribb24-dev
sudo apt install libbluray-dev
```

直接sudo bash ./install.sh<br />
如果有问题，就看一下Dockerfile

编译transcoding.c
```
rm -rf transcoding && gcc -L lib/ -I include/ transcoding.c -lavcodec -lavformat -lavfilter -lavutil -o transcoding
```
编译laliu.c
```
rm -rf laliu && gcc -L lib/ -I include/ laliu.c -lavcodec -lavformat -lavfilter -lavutil -o laliu
```
