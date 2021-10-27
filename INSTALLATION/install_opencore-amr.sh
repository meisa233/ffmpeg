	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
    DIR=/tmp/opencore-amr && \
	mkdir -p ${DIR} && \
	cp opencore-amr-0.1.5.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zx --strip-components=1 -f opencore-amr-0.1.5.tar.gz && \
        ./configure --prefix="${PREFIX}" --enable-shared  && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

