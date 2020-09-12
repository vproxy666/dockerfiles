FROM docker:19-dind-rootless

USER root
ENV CROSS_DOCKER_IN_DOCKER=true


RUN apk update; \
    apk add build-base gcc curl git zip mingw-w64-gcc mingw-w64-winpthreads mingw-w64-crt; \
    rm -rf /var/cache/apk/*; \
    curl -o /rustup-init https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-musl/rustup-init && \
    chmod +x /rustup-init; \
    /rustup-init -y; \
    rm -f /rustup-init; \
    source $HOME/.cargo/env; \
    cargo install cross; \
    rustup target add x86_64-pc-windows-gnu; \
    rustup target add x86_64-unknown-linux-gnu; \
    rustup target add x86_64-unknown-linux-musl; \
    rustup target add aarch64-unknown-linux-gnu; \
    rustup target add aarch64-unknown-linux-musl; \
    rustup target add aarch64-linux-android;

ENV PATH="/root/.cargo/bin:${PATH}"

ADD ghr /usr/bin/ghr
RUN chmod +x /usr/bin/ghr && \
    printf "\n[target.x86_64-pc-windows-gnu]" >> ~/.cargo/config  && \
    printf "\nlinker = \"/usr/bin/x86_64-w64-mingw32-gcc\"" >> ~/.cargo/config







