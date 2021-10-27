        DIR=/tmp/srt && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        mkdir -p ${DIR} && \
	cp srt-1.4.1.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -xz --strip-components=1 -f srt-1.4.1.tar.gz && \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" . && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

