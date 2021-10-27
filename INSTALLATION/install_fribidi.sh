DIR=/tmp/fribidi && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
	FRIBIDI_SHA256SUM="3fc96fa9473bd31dcb5500bdf1aa78b337ba13eb8c301e7c28923fea982453a8 fribidi-0.19.7.tar.gz" && \
        mkdir -p ${DIR} && \
	cp fribidi-0.19.7.tar.gz ${DIR}/ && \
        cd ${DIR} && \
        echo ${FRIBIDI_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f fribidi-0.19.7.tar.gz && \
        sed -i 's/^SUBDIRS =.*/SUBDIRS=gen.tab charset lib bin/' Makefile.am && \
        ./bootstrap --no-config --auto && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make -j1 && \
        make install && \
        rm -rf ${DIR}

