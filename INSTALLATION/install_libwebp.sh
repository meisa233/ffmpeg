	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        DIR=/tmp/vebp && \
        mkdir -p ${DIR} && \
	cp libwebp-1.0.2.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zx --strip-components=1 -f libwebp-1.0.2.tar.gz && \
        ./configure --prefix="${PREFIX}" --enable-shared  && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

