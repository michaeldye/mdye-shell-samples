from ubuntu:latest
add . /src
env DEBIAN_FRONTEND=noninteractive
run apt-get update && apt-get install -y bc make bsdextrautils shellcheck 
run rm -rf /var/cache/apt/archives /var/lib/apt/lists
workdir /src
