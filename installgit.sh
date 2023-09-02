!/bin/bash

install_git_debian() {
    sudo apt-get update
    sudo apt-get install -y git
}

install_git_redhat() {
    sudo yum install -y git
}

install_git_amazon_linux() {
    sudo amazon-linux-extras install -y git2
}

install_git_suse_linux() {
    sudo zypper install -y git
}

if [ -f /etc/os-release ]; then
    source /etc/os-release
    if [[ $ID == "ubuntu" || $ID == "debian" ]]; then
        echo "Detected Debian-based distribution. Installing Git..."
        # install_git_debian
    elif [[ $ID == "centos" || $ID == "fedora" ]]; then
        echo "Detected Red Hat-based distribution. Installing Git..."
        install_git_redhat
    elif [[ $ID == "amzn" ]]; then
        echo "Detected Amazon Linux distribution. Installing Git..."
        install_git_amazon_linux
    elif [[ $ID == "suse" ]]; then
        echo "Detected SUSE Linux distribution. Installing Git..."
        install_git_suse_linux
    else
        echo "Unsupported distribution: $ID. Please install Git manually."
        exit 1
    fi
else
    echo "Unable to determine the distribution. Please install Git manually."
    exit 1
fi

git --version

echo "Git has been successfully installed."