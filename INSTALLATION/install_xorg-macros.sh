DIR=/tmp/xorg-macros && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        mkdir -p ${DIR} && \
	cp util-macros-1.19.2.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zx --strip-components=1 -f util-macros-1.19.2.tar.gz && \
        ./configure --srcdir=${DIR} --prefix="${PREFIX}" && \
        make -j8 install && \
        rm -rf ${DIR}

