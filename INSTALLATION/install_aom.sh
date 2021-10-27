        DIR=/tmp/aom && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
	mkdir -p ${DIR} && \
	cp -r ./aom ${DIR}/ && \
        cd ${DIR} && \
        rm -rf CMakeCache.txt CMakeFiles && \
        mkdir -p ./aom_build && \
        cd ./aom_build && \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" -DBUILD_SHARED_LIBS=1 ../aom && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

