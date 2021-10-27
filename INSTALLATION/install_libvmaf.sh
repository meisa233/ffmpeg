		PREFIX=/home/warlock/rtmp_project/ffmpeg/build
		LIBVMAF_VERSION=2.1.1
        if which meson || false; then \
                echo "Building VMAF." && \
                DIR=/tmp/vmaf && \
                mkdir -p ${DIR} && \
				cp vmaf-2.1.1.tar.gz ${DIR}/ && \
                cd ${DIR} && \
                tar -xz --strip-components=1 -f vmaf-2.1.1.tar.gz && \
                cd /tmp/vmaf/libvmaf && \
                meson build --buildtype release --prefix=${PREFIX} && \
                ninja -vC build && \
                ninja -vC build install && \
                mkdir -p ${PREFIX}/share/model/ && \
                cp -r /tmp/vmaf/model/* ${PREFIX}/share/model/ && \
                rm -rf ${DIR}; \
        else \
                echo "VMAF skipped."; \
        fi

