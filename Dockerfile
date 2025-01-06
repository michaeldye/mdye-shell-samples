from ubuntu:latest
add . /src
env DEBIAN_FRONTEND=noninteractive
run apt-get update && apt-get install -y bc make bsdextrautils shellcheck
workdir /src
run make test
