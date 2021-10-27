        DIR=/tmp/vid.stab && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
	LIBVIDSTAB_SHA256SUM="14d2a053e56edad4f397be0cb3ef8eb1ec3150404ce99a426c4eb641861dc0bb vid.stab-1.1.0.tar.gz" && \
        mkdir -p ${DIR} && \
	cp vid.stab-1.1.0.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        echo ${LIBVIDSTAB_SHA256SUM} | sha256sum --check &&  \
        tar -zx --strip-components=1 -f vid.stab-1.1.0.tar.gz && \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" . && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

