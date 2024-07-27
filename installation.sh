#!/bin/bash

# Install flatpak and snapd

essentials() {
    # Check if flatpak is installed
    if ! command -v flatpak >dev/null 2>&1; then
        echo "Flatpak is not installed. Installing flatpak..."
        sudo apt install flatpak -y
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    else
        echo "Flatpak is already installed."
    fi

    if ! command -v snap >dev/null 2>&1; then
        echo "Snap is not installed. Installing snap..."
        sudo apt install snapd -y
        sudo snap install core
    else
        echo "Snapd is already installed."
    fi

    echo "-------------------------------------"
}

Progamming() {
    #C++
    echo "** Installing C++ and its essentials...**"
    sudo apt install gcc g++ gdb -y
    echo "C++ installed successfully."

    #Java
    echo "** Installing Java... **"
    sudo apt install openjdk-17-jdk openjdk-17-jre -y
    echo "** Installed OpenJDK 17 successfully **"

    # C#
    read -p "Do you want to install C# and dotnet-sdk-8.0 package? (y/n): " answer
    if [[ $answer == "y" || $answer == "Y" ]]; then
        echo "Installing C# and Dotnet .."
        wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        sudo dpkg -i packages-microsoft-prod.deb
        rm packages-microsoft-prod.deb

        sudo apt-get update &&
            sudo apt-get install -y dotnet-sdk-8.0 &&
            sudo apt-get install -y mono-complete
    fi
}

Apps() {
    Browser
}

Browser() {
    echo "Do you want to install brave? Y/N"
    read -r browser
    if [[ $browser == "Y" || $browser == "y" ]]; then
        echo "Installing Brave..."
        sudo apt install curl
        sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
        sudo apt update
        sudo apt install brave-browser
    else
        echo "Skipping Brave installation."
    fi
}

discord() {}

Apps() {
    Browser
}

# --------------------- Call Functions ---------------

essentials
Apps
