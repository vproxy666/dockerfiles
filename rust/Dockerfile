FROM docker:19-dind-rootless


RUN apt-get update -y; \
    apt-get install -y mingw-w64 build-essential curl binfmt-support qemu-user-static git zip; \
    apt-get clean; \
    curl -o /rustup-init https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init; \
    chmod +x /rustup-init; \
    /rustup-init -y; \
    rm -f /rustup-init

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






