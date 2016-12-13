FROM scratch
# If required, supply CA certificates:
# ADD ca-certificates.crt /etc/ssl/certs/
ADD target/x86_64-unknown-linux-musl/release/static-rust-app /
CMD ["/static-rust-app"]

