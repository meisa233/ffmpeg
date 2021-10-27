        DIR=/tmp/libxml2 && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
	LIBXML2_SHA256SUM="f07dab13bf42d2b8db80620cce7419b3b87827cc937c8bb20fe13b8571ee9501  libxml2-v2.9.10.tar.gz" && \
        mkdir -p ${DIR} && \
	cp libxml2-v2.9.10.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        echo ${LIBXML2_SHA256SUM} | sha256sum --check && \
        tar -xz --strip-components=1 -f libxml2-v2.9.10.tar.gz && \
        ./autogen.sh --prefix="${PREFIX}" --with-ftp=no --with-http=no --with-python=no && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

