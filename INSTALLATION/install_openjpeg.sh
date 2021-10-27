PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
	DIR=/tmp/openjpeg && \
        mkdir -p ${DIR} && \
	cp openjpeg-2.1.2.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zx --strip-components=1 -f openjpeg-2.1.2.tar.gz && \
        cmake -DBUILD_THIRDPARTY:BOOL=ON -DCMAKE_INSTALL_PREFIX="${PREFIX}" . && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

