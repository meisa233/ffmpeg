        DIR=/tmp/libbluray && \
	PREFIX=/home/warlock/rtmp_project/ffmpeg/build && \
	LIBBLURAY_SHA256SUM="a3dd452239b100dc9da0d01b30e1692693e2a332a7d29917bf84bb10ea7c0b42 libbluray-1.1.2.tar.bz2" && \
        mkdir -p ${DIR} && \
	cp libbluray-1.1.2.tar.bz2 ${DIR}/ && \
        cd ${DIR} && \
        echo ${LIBBLURAY_SHA256SUM} | sha256sum --check && \
        tar -jx --strip-components=1 -f libbluray-1.1.2.tar.bz2 && \
        ./configure --prefix="${PREFIX}" --disable-examples --disable-bdjava-jar --disable-static --enable-shared && \
        make -j8 && \
        make install && \
        rm -rf ${DIR}

