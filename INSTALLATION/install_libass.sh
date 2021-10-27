        DIR=/tmp/libass && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
	LIBASS_SHA256SUM="8fadf294bf701300d4605e6f1d92929304187fca4b8d8a47889315526adbafd7 libass-0.13.7.tar.gz" && \
        mkdir -p ${DIR} && \
	cp libass-0.13.7.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        echo ${LIBASS_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f libass-0.13.7.tar.gz && \
        ./autogen.sh && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

