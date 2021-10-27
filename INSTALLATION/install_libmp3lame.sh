        DIR=/tmp/lame && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        mkdir -p ${DIR} && \
	cp lame-3.100.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zx --strip-components=1 -f lame-3.100.tar.gz && \
        ./configure --prefix="${PREFIX}" --bindir="${PREFIX}/bin" --enable-shared --enable-nasm --disable-frontend && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}
