FROM alpine:3.10
MAINTAINER Evgeny Golyshev <eugulixes@gmail.com>

ENV BUNDLE_DIR /root/bundle

ENV LD_LIBRARY_PATH /lib:/usr/lib

# Rocket.Chat Buildmaster <buildmaster@rocket.chat>
ENV PUBLIC_KEY 0E163286C20D07B9787EBE9FD7F9D0414FD08104

ENV RC_VERSION 1.3.1

COPY patches /root/patches

RUN apk --update add \
    bash \
    coreutils \
    curl \
    g++ \
    gnupg \
    libstdc++ \
    make \
    patch \
    python \
    sudo \
    vips \
 # Install Rocket.Chat
 && for i in $(seq 1 10); do \
      gpg --no-tty --keyserver ha.pool.sks-keyservers.net --recv-keys $PUBLIC_KEY && break; \
      rm -r /root/.gnupg; \
    done \
 && cd \
 # glibc
 && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
 && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk \
 && apk add glibc-2.28-r0.apk \
 # Node
 && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash \
 # Rocket.Chat itself
 && curl -fSL https://releases.rocket.chat/$RC_VERSION/download -o rocket.chat.tgz \
 && curl -fSL https://releases.rocket.chat/$RC_VERSION/asc -o rocket.chat.tgz.asc \
 && tar zxf rocket.chat.tgz \
 && rm rocket.chat.tgz rocket.chat.tgz.asc \
 && cd $BUNDLE_DIR \
 # Patches apply
 && for path in $(ls ../patches/) \
 ; do patch -p1 < "../patches/${path}" \
 ; done \
 && cd programs/server \
 && rm -r npm/node_modules/sharp/vendor \
 && . ~/.nvm/nvm.sh && nvm install 8 && npm install \
 && curl -O https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
 && chmod +x wait-for-it.sh \
 && mv wait-for-it.sh /usr/local/bin \
 # Cleanup
 && apk del \
    g++ \
    gnupg \
    make \
    patch \
    python \
    sudo \
 && cd \
 && rm      glibc-2.28-r0.apk \
 && rm -r   patches \
 && rm -rf /var/cache/apk/*

WORKDIR $BUNDLE_DIR

COPY docker-entrypoint.sh /usr/local/bin/

CMD ["docker-entrypoint.sh"]
