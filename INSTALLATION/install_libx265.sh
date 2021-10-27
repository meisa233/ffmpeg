        PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
        DIR=/tmp/x265 && \
        mkdir -p ${DIR} && \
	    cp x265-3.4.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        tar -zxvf x265-3.4.tar.gz && \
        cd x265-3.4/build/linux && \
        sed -i "/-DEXTRA_LIB/ s/$/ -DCMAKE_INSTALL_PREFIX=\${PREFIX}/" multilib.sh && \
        sed -i "/^cmake/ s/$/ -DENABLE_CLI=OFF/" multilib.sh && \
        ./multilib.sh && \
        make -C 8bit -j8 install && \
        rm -rf ${DIR}

