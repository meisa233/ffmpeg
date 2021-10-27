        DIR=/tmp/libzmq && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
	LIBZMQ_SHA256SUM="02ecc88466ae38cf2c8d79f09cfd2675ba299a439680b64ade733e26a349edeb libzmq-4.3.2.tar.gz" && \
        mkdir -p ${DIR} && \
	cp libzmq-4.3.2.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        echo ${LIBZMQ_SHA256SUM} | sha256sum --check && \
        tar -xz --strip-components=1 -f libzmq-4.3.2.tar.gz && \
        ./autogen.sh && \
        ./configure --prefix="${PREFIX}" && \
        make -j8 && \
        make check && \
        make install && \
        rm -rf ${DIR}

