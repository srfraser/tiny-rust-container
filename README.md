To create small rust containers, we must remove as many external dependencies as possible. The first step for this is statically linking the application. 

### Install rustup

`rustup` does not work alongside existing installations of rust, so you will need a rust-free system before following the instructions at https://www.rustup.rs/

    curl https://sh.rustup.rs -sSf | sh
    source $HOME/.cargo/env

### Add compilation target

    $ rustup target add x86_64-unknown-linux-musl
    info: downloading component 'rust-std' for 'x86_64-unknown-linux-musl'
      8.0 MiB /   8.0 MiB (100 %)   1.2 MiB/s ETA:   0 s
    info: installing component 'rust-std' for 'x86_64-unknown-linux-musl'

### Build for the new target

    cargo build --release --target=x86_64-unknown-linux-musl
    
Now we can confirm that it's statically linked:

    $ ldd target/x86_64-unknown-linux-musl/release/static-rust-app
            not a dynamic executable

### Build the docker container 

The docker image uses 'scratch' as the source, which starts completely empty. This means we need to add all dependencies. Since we are statically linking the application, this should just be configuration files and if using SSL, adding
`/etc/ssl/certs/ca-certiicates.crt`

    docker build -t rust-basic1 -f Dockerfile .

The resulting image is just over one megabyte, for this example:

    $ docker images | rust-basic1
    REPOSITORY          TAG                 IMAGE ID            CREATED          SIZE
    rust-basic1         latest              2c65f1bbb700        28 seconds ago      1.028 MB

    $ docker run rust-basic1
    Hello, World!

### Further Reading

Cross compilation with rustup
https://blog.rust-lang.org/2016/05/13/rustup.html

### TODO

Cross-compilation from MacOS to Linux involves adding an ELF-aware linker, which I've not yet investigated. 
