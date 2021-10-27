PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        DIR=/tmp/freetype && \
	FREETYPE_SHA256SUM="5eab795ebb23ac77001cfb68b7d4d50b5d6c7469247b0b01b2c953269f658dac freetype-2.10.4.tar.gz" && \
	mkdir -p ${DIR} && \
	cp freetype-2.10.4.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        echo ${FREETYPE_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f freetype-2.10.4.tar.gz && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

