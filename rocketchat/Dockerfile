FROM node:8-alpine
MAINTAINER Evgeny Golyshev <eugulixes@gmail.com>

ENV BUNDLE_DIR /home/rocketchat/bundle

# Rocket.Chat Buildmaster <buildmaster@rocket.chat>
ENV PUBLIC_KEY 0E163286C20D07B9787EBE9FD7F9D0414FD08104

ENV RC_VERSION 1.3.1

COPY patches /home/rocketchat/patches

# Alpine 3.9 is used but it's necessary to install vips which is a part of
# Alpine 3.10 and later, so add the Alpine 3.10 repo to install the package.
RUN echo http://mirror.yandex.ru/mirrors/alpine/v3.10/community >> /etc/apk/repositories \
 && apk --update add \
    bash \
    curl \
    g++ \
    gnupg \
    make \
    patch \
    python \
    vips \
 && adduser -D rocketchat \
 # Install Rocket.Chat
 && for i in $(seq 1 10); do \
      gpg --no-tty --keyserver ha.pool.sks-keyservers.net --recv-keys $PUBLIC_KEY && break; \
      rm -r /root/.gnupg; \
    done \
 && cd /home/rocketchat \
 && curl -fSL https://releases.rocket.chat/$RC_VERSION/download -o rocket.chat.tgz \
 && curl -fSL https://releases.rocket.chat/$RC_VERSION/asc -o rocket.chat.tgz.asc \
 && gpg --batch --verify rocket.chat.tgz.asc rocket.chat.tgz \
 && tar zxf rocket.chat.tgz \
 && rm rocket.chat.tgz rocket.chat.tgz.asc \
 && cd $BUNDLE_DIR \
 # Patches apply
 && for path in $(ls ../patches/) \
 ; do patch -p1 < "../patches/${path}" \
 ; done \
 && cd programs/server \
 && rm -r npm/node_modules/sharp/vendor \
 && npm install \
 && curl -O https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
 && chmod +x wait-for-it.sh \
 && mv wait-for-it.sh /usr/local/bin \
 # Cleanup
 && apk del \
    curl \
    g++ \
    gnupg \
    make \
    patch \
    python \
 && rm -rf /var/cache/apk/*

WORKDIR $BUNDLE_DIR

USER rocketchat

COPY docker-entrypoint.sh /usr/local/bin/

CMD ["docker-entrypoint.sh"]
