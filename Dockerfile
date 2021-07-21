FROM frolvlad/alpine-glibc:latest
MAINTAINER Claude Henchoz <claude.henchoz@gmail.com>
ENV CALIBRE_INSTALLER_SOURCE_CODE_URL https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/calibre/lib
ENV PATH $PATH:/opt/calibre/bin
RUN apk update && \
    apk add --no-cache --upgrade \
    bash \
    ca-certificates \
    gcc \
    mesa-gl \
    python3 \
    qt5-qtbase-x11 \
    wget \
    xdg-utils \
    xz && \
    wget -O - ${CALIBRE_INSTALLER_SOURCE_CODE_URL} | python3 -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(install_dir='/opt', isolated=True)" && \
    rm -rf /tmp/calibre-installer-cache
