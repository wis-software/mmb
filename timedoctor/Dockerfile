FROM ubuntu:xenial
MAINTAINER Evgeny Golyshev <eugulixes@gmail.com>

ENV TERM linux

COPY timedoctorlite_2.3.49-14ubuntu16.04_amd64.deb /timedoctorlite_2.3.49-14ubuntu16.04_amd64.deb

RUN apt-get update \
 && apt-get install -y \
    gdebi \
    gksu \
    libssl1.0.0 \
    libqt4-dbus \
    libqt4-network \
    libqt4-sql \
    libqt4-sql-sqlite \
    libqt4-svg \
    libqt4-xml \
    libqtcore4 \
    libpng16-16 \
    libqtgui4 \
    libcv2.4 \
    libx11-xcb1 \
    libxcb-record0 \
    libxcb1 \
 && dpkg -i /timedoctorlite_2.3.49-14ubuntu16.04_amd64.deb \
 && useradd -m timedoctor \
 # Cleanup
 && rm /timedoctorlite_2.3.49-14ubuntu16.04_amd64.deb \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER timedoctor

CMD ["timedoctorlite"]
