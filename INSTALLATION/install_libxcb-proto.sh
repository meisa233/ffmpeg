        DIR=/tmp/libxcb-proto && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        mkdir -p ${DIR} && \
	cp xcb-proto-1.13.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zx --strip-components=1 -f xcb-proto-1.13.tar.gz && \
        ACLOCAL_PATH="${PREFIX}/share/aclocal" ./autogen.sh && \
        ./configure --prefix="${PREFIX}" && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

