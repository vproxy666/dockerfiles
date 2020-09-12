FROM docker:19-dind-rootless

USER root
RUN apk update; \
    apk add build-base gcc curl git zip; \
    rm -rf /var/cache/apk/*; \
    curl -o /rustup-init https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-musl/rustup-init && \
    chmod +x /rustup-init; \
    /rustup-init -y; \
    rm -f /rustup-init; \
    cargo install cross;

RUN rustup target add x86_64-pc-windows-gnu; \
    rustup target add x86_64-unknown-linux-gnu; \
    rustup target add x86_64-apple-darwin; \
    rustup target add aarch64-unknown-linux-gnu; \
    rustup target add aarch64-unknown-linux-musl;

ADD ghr /usr/bin/ghr
RUN chmod +x /usr/bin/ghr && \
    mkdir ~/.cargo/ && \
    printf "\n[target.x86_64-pc-windows-gnu]" >> ~/.cargo/config  && \
    printf "\nlinker = \"/usr/bin/x86_64-w64-mingw32-gcc\"" >> ~/.cargo/config


ENV CROSS_DOCKER_IN_DOCKER=true





