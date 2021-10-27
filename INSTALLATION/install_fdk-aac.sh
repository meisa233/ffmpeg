PREFIX=/home/warlock/rtmp_project/ffmpeg/build
DIR=/tmp/fdk-aac && \
FDKAAC_VERSION=0.1.5 && \
        mkdir -p ${DIR} && \
	cp fdk-aac-0.1.5.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zx --strip-components=1 -f fdk-aac-0.1.5.tar.gz && \
        autoreconf -fiv && \
        ./configure --prefix="${PREFIX}" --enable-shared --datadir="${DIR}" && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

