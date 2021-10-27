        DIR=/tmp/png && \
		PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        mkdir -p ${DIR} && \
		cp -r ./png ${DIR}/ && \
        cd ${DIR} && \
        ./autogen.sh && \
        ./configure --prefix="${PREFIX}" && \
        make check -j8 && \
        make install && \
        rm -rf ${DIR}