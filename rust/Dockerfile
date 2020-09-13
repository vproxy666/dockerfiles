FROM circleci/buildpack-deps:buster-dind

USER root

RUN apt-get update -y; \
    apt-get install -y mingw-w64 build-essential curl binfmt-support qemu-user-static git zip musl-tools; \
    apt-get clean; \
    curl -o /rustup-init https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init && \
    chmod +x /rustup-init; \
    /rustup-init -y --no-modify-path; \
    rm -f /rustup-init;

ENV PATH="/root/.cargo/bin:${PATH}"

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






