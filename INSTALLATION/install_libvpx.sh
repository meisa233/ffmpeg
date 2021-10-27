        DIR=/tmp/vpx && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build
        mkdir -p ${DIR} && \
	cp libvpx-1.8.0.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zx --strip-components=1 -f libvpx-1.8.0.tar.gz && \
        ./configure --prefix="${PREFIX}" --enable-vp8 --enable-vp9 --enable-vp9-highbitdepth --enable-pic --enable-shared \
        --disable-debug --disable-examples --disable-docs --disable-install-bins  && \
        make -j8  install && \
        rm -rf ${DIR}

