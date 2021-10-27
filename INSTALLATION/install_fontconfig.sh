DIR=/tmp/fontconfig && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        mkdir -p ${DIR} && \
	cp fontconfig-2.12.4.tar.bz2 ${DIR}/ && \
        cd ${DIR} && \
        tar -jx --strip-components=1 -f fontconfig-2.12.4.tar.bz2 && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

