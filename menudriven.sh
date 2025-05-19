#!/bin/bash

# Function to install Docker
install_docker() {
    echo "Installing Docker..."
    if ! [ -x "$(command -v docker)" ]; then
        sudo apt-get update
        sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        sudo apt-get update
        sudo apt-get install -y docker-ce
        sudo systemctl enable docker
        sudo systemctl start docker
        echo "Docker installed successfully!"
    else
        echo "Docker is already installed!"
    fi
}


# Function to install Kubernetes
install_kubernetes() {
    echo "Installing Kubernetes..."
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl
    echo "Kubernetes installed successfully!"
}


# Function to install Jenkins
install_jenkins() {
    echo "Installing Jenkins..."
    # Update package list
    echo "Updating package list..."
    sudo apt-get update

    # Upgrade installed packages
    echo "Upgrading installed packages..."
    sudo apt-get upgrade -y

    # Install required packages
    echo "Installing fontconfig and OpenJDK 17 runtime..."
    sudo apt-get install -y fontconfig openjdk-17-jre

    # Install OpenJDK 17 headless
    echo "Installing OpenJDK 17 headless..."
    sudo apt install -y openjdk-17-jdk-headless

    # Add Jenkins keyring
    echo "Adding Jenkins keyring..."
    sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

    # Add Jenkins repository
    echo "Adding Jenkins repository..."
    echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list

    # Update package list again after adding Jenkins repository
    echo "Updating package list again..."
    sudo apt-get update

    # Install Jenkins
    echo "Installing Jenkins..."
    sudo apt-get install -y jenkins

    # Enable Jenkins to start on boot
    echo "Enabling Jenkins to start on boot..."
    sudo systemctl enable jenkins

    # Start Jenkins service
    echo "Starting Jenkins service..."
    sudo systemctl start jenkins

    # Check Jenkins service status
    echo "Checking Jenkins service status..."
    sudo systemctl status jenkins

    # Display the initial admin password
    echo "Displaying the initial admin password..."
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
}


# Main menu
while true; do
    echo "Select an option:"
    echo "1. Install Docker"
    echo "2. Install Kubernetes"
    echo "3. Install Jenkins"
    echo "4. Exit"
    read -p "Enter your choice: " choice
    case $choice in
        1) install_docker ;;
        2) install_kubernetes ;;
        3) install_jenkins ;;
        4) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done
