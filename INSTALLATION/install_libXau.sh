PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
	        DIR=/tmp/libXau && \
        mkdir -p ${DIR} && \
	cp libXau-1.0.9.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zx --strip-components=1 -f libXau-1.0.9.tar.gz && \
        ./configure --srcdir=${DIR} --prefix="${PREFIX}" && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

