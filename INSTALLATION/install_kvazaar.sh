        DIR=/tmp/kvazaar && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        mkdir -p ${DIR} && \
	cp kvazaar-2.0.0.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zx --strip-components=1 -f kvazaar-2.0.0.tar.gz && \
        ./autogen.sh && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

