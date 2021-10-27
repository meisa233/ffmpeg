	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
	THEORA_SHA256SUM="40952956c47811928d1e7922cda3bc1f427eb75680c3c37249c91e949054916b libtheora-1.1.1.tar.gz" && \
        DIR=/tmp/theora && \
        mkdir -p ${DIR} && \
	cp libtheora-1.1.1.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        echo ${THEORA_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f libtheora-1.1.1.tar.gz && \
        ./configure --prefix="${PREFIX}" --with-ogg="${PREFIX}" --enable-shared && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

