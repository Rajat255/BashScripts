#!/bin/bash

# Function to check the Linux distribution
get_linux_distribution() {
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        echo "$ID"
    else
        echo "Unsupported distribution"
        exit 1
    fi
}

install_minikube() {
    echo "Installing Minikube..."
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    chmod +x minikube
    sudo mv minikube /usr/local/bin/
}

# Get the Linux distribution
distro=$(get_linux_distribution)
echo "Linux Distribution Detected:" $distro 

case $distro in
    "ubuntu" | "debian")
        sudo apt update
        sudo apt install -y curl
        install_minikube
        ;;

    "centos" | "rhel" | "fedora")
        sudo yum install -y curl
        install_minikube
        ;;

    "amazon")
        sudo yum install -y curl
        install_minikube
        ;;

    "opensuse" | "opensuse-leap" | "opensuse-tumbleweed")
        sudo zypper install -y curl
        install_minikube
        ;;

    *)
        echo "Unsupported distribution: $distro"
        exit 1
        ;;
esac

minikube version
