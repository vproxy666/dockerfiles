FROM rust:slim-buster


RUN apt-get update -y; \
    apt-get install -y mingw-w64 build-essential curl binfmt-support qemu-user-static git; \
    apt-get clean; 

RUN rustup target add x86_64-pc-windows-gnu; \
    rustup target add x86_64-unknown-linux-gnu; \
    rustup target add x86_64-apple-darwin; \
    rustup target add aarch64-unknown-linux-gnu; \
    rustup target add aarch64-unknown-linux-musl;


RUN mkdir ~/.cargo/ && \
    printf "\n[target.x86_64-pc-windows-gnu]" >> ~/.cargo/config  && \
    printf "\nlinker = \"/usr/bin/x86_64-w64-mingw32-gcc\"" >> ~/.cargo/config && \
    printf "\nar = \"/usr/bin/x86_64-w64-mingw32-gcc-ar\"" >> ~/.cargo/config && \
    printf "\nranlib = \"/usr/bin/x86_64-w64-mingw32-gcc-ranlib\"" >> ~/.cargo/config && \
    printf "\ncrt-static = true" >> ~/.cargo/config 



