        DIR=/tmp/ogg && \
	    OGG_SHA256SUM="e19ee34711d7af328cb26287f4137e70630e7261b17cbe3cd41011d73a654692 libogg-1.3.2.tar.gz" && \
	    PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        mkdir -p ${DIR} && \
	    cp libogg-1.3.2.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        echo ${OGG_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f libogg-1.3.2.tar.gz && \
        ./configure --prefix="${PREFIX}" --enable-shared  && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

