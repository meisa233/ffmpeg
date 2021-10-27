DIR=/tmp/libpthread-stubs && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        mkdir -p ${DIR} && \
	cp libpthread-stubs-0.4.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zx --strip-components=1 -f libpthread-stubs-0.4.tar.gz && \
        ./configure --prefix="${PREFIX}" && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

