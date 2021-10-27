        DIR=/tmp/xproto && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        mkdir -p ${DIR} && \
	cp xproto-7.0.31.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zx --strip-components=1 -f xproto-7.0.31.tar.gz && \
        ./configure --srcdir=${DIR} --prefix="${PREFIX}" && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

