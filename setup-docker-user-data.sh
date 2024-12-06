#!/bin/bash
apt-get update
apt-get install -y docker.io

mkdir -p /etc/docker
cat <<EOF > /etc/docker/daemon.json
{
  "hosts": ["unix:///var/run/docker.sock", "tcp://127.0.0.1:2375"]
}
EOF

systemctl restart docker

usermod -aG docker ubuntu
