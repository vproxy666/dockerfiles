FROM rust:slim-buster

# https://github.com/CircleCI-Public/circleci-dockerfiles/blob/master/buildpack-deps/images/buster/dind/Dockerfile

RUN apt-get update -y; \
    apt-get install -y mingw-w64 build-essential binfmt-support qemu-user-static musl-tools \
    git mercurial xvfb apt sudo \
    locales openssh-client ca-certificates tar gzip parallel \
    net-tools netcat unzip zip bzip2 gnupg curl wget iptables xz-utils btrfs-progs; \
    apt-get clean; 

RUN set -ex \
  && export DOCKER_VERSION=docker-19.03.12.tgz \
  && DOCKER_URL="https://download.docker.com/linux/static/stable/x86_64/${DOCKER_VERSION}" \
  && echo Docker URL: $DOCKER_URL \
  && curl --silent --show-error --location --fail --retry 3 --output /tmp/docker.tgz "${DOCKER_URL}" \
  && ls -lha /tmp/docker.tgz \
  && tar -xz -C /tmp -f /tmp/docker.tgz \
  && mv /tmp/docker/* /usr/bin \
  && rm -rf /tmp/docker /tmp/docker.tgz \
  && which docker \
  && (docker version || true)


# set up subuid/subgid so that "--userns-remap=default" works out-of-the-box
RUN set -x \
    && addgroup --system dockremap \
    && adduser --system --ingroup dockremap dockremap \
    && echo 'dockremap:165536:65536' >> /etc/subuid \
    && echo 'dockremap:165536:65536' >> /etc/subgid

ENV DIND_COMMIT 3b5fac462d21ca164b3778647420016315289034

RUN wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind" \
    && chmod +x /usr/local/bin/dind

RUN set -x \
    && addgroup --system docker

# avoid creating separate files and embed file here
RUN printf '#!/bin/sh \n\
set -e \n\
if [ "$#" -eq 0 -o "${1#-}" != "$1" ]; then \n\
    set -- dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 "$@" \n\
fi \n\
 \n\
if [ "$1" = 'dockerd' ]; then \n\
    set -- sudo sh "$(which dind)" "$@" \n\
fi \n\
 \n\
exec "$@" \n\
' > /usr/local/bin/dockerd-entrypoint.sh \
   && chmod +x /usr/local/bin/dockerd-entrypoint.sh

VOLUME /var/lib/docker

ENTRYPOINT ["dockerd-entrypoint.sh"]

# https://doc.rust-lang.org/nightly/rustc/platform-support.html
RUN cargo install cross; \
    rustup target add x86_64-pc-windows-gnu; \
    rustup target add x86_64-unknown-linux-gnu; \
    rustup target add x86_64-unknown-linux-musl; \
    rustup target add aarch64-unknown-linux-gnu; \
    rustup target add aarch64-unknown-linux-musl; \
    rustup target add armv7-unknown-linux-musleabihf; 

ADD ghr /usr/bin/ghr
RUN chmod +x /usr/bin/ghr && \
    printf "\n[target.x86_64-pc-windows-gnu]" >> ~/.cargo/config  && \
    printf "\nlinker = \"/usr/bin/x86_64-w64-mingw32-gcc\"" >> ~/.cargo/config
    






