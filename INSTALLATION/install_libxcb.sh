        DIR=/tmp/libxcb && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        mkdir -p ${DIR} && \
	cp libxcb-1.13.1.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zx --strip-components=1 -f libxcb-1.13.1.tar.gz && \
        ACLOCAL_PATH="${PREFIX}/share/aclocal" ./autogen.sh && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

