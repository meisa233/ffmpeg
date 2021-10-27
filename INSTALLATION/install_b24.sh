        DIR=/tmp/b24 && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
	LIBARIBB24_SHA256SUM="f61560738926e57f9173510389634d8c06cabedfa857db4b28fb7704707ff128 aribb24-1.0.3.tar.gz" && \
        mkdir -p ${DIR} && \
	cp aribb24-1.0.3.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        echo ${LIBARIBB24_SHA256SUM} | sha256sum --check && \
        tar -xz --strip-components=1 -f aribb24-1.0.3.tar.gz && \
        autoreconf -fiv && \
        ./configure CFLAGS="-I${PREFIX}/include -fPIC" --prefix="${PREFIX}" && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

