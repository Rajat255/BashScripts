#!/bin/bash

if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Unable to detect the Linux distribution."
    exit 1
fi

case $DISTRO in
    "opensuse-leap" | "opensuse-tumbleweed" | "suse")
        sudo zypper -n install docker
        ;;

    "debian")
        sudo apt-get update
        sudo apt-get -y install docker.io
        ;;

    "ubuntu")
        sudo apt-get update
        sudo apt-get -y install docker.io
        ;;

    "rhel" | "centos" | "amzn")
        sudo yum -y install docker
        ;;

    *)
        echo "Unsupported distribution: $DISTRO"
        exit 1
        ;;
esac

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $USER

echo "Docker has been installed and Started successfully."
