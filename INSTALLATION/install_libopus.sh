	OPUS_SHA256SUM="77db45a87b51578fbc49555ef1b10926179861d854eb2613207dc79d9ec0a9a9 opus-1.2.tar.gz"
        PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        DIR=/tmp/opus && \
        mkdir -p ${DIR} && \
	cp opus-1.2.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        echo ${OPUS_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f opus-1.2.tar.gz && \
        autoreconf -fiv && \
        ./configure --prefix="${PREFIX}" --enable-shared && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

