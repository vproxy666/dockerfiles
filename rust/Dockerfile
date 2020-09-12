FROM docker:19-dind-rootless

USER root
ENV CROSS_DOCKER_IN_DOCKER=true


RUN apk update; \
    apk add build-base gcc curl git zip mingw-w64-binutils; \
    rm -rf /var/cache/apk/*; \
    curl -o /rustup-init https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-musl/rustup-init && \
    chmod +x /rustup-init; \
    /rustup-init -y; \
    rm -f /rustup-init; \
    source $HOME/.cargo/env; \
    cargo install cross; \
    find / -name *mingw*; \
    ls ~/.cargo/; \
    rustup target add x86_64-pc-windows-gnu;


ADD ghr /usr/bin/ghr
RUN chmod +x /usr/bin/ghr && \
    mkdir ~/.cargo/ && \
    printf "\n[target.x86_64-pc-windows-gnu]" >> ~/.cargo/config  && \
    printf "\nlinker = \"/usr/bin/x86_64-w64-mingw32-gcc\"" >> ~/.cargo/config







