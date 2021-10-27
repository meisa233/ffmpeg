	    PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        DIR=/tmp/x264 && \
        mkdir -p ${DIR} && \
	    cp x264-snapshot-20170226-2245-stable.tar.bz2 ${DIR}/ && \
        cd ${DIR} && \
        tar -jx --strip-components=1 -f x264-snapshot-20170226-2245-stable.tar.bz2 && \
        ./configure --prefix="${PREFIX}" --enable-shared --enable-pic --disable-cli && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

