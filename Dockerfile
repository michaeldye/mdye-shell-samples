from ubuntu:latest
add . /shell
env DEBIAN_FRONTEND=noninteractive
run apt-get update && apt-get install -y bc make bsdextrautils shellcheck inotify-tools && \
    rm -rf /var/cache/apt/archives /var/lib/apt/lists
workdir /shell
cmd ["./util/target-on-change.bash", "inspect"]
