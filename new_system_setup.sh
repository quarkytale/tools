#!/bin/bash


## Prep
# configs to copy over:
# pat
# .bash_history
# .bashrc
# .config
# .gitonfig
# .ssh
# .vimrc
# .vscode


echo "new laptop, who dis"

## Common Dependencies
sudo apt install -y \
  apt-utils \
  ca-certificates \
  software-properties-common \
  apt-transport-https \
  wget \
  vim \
  lsb-release \
  gnupg \
  curl

## Google Chrome
echo "Install Google Chrome? [Y,n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install -y ./google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb
fi

## Terminator
echo "Install Terminator? [Y,n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
  sudo apt install -y terminator
fi

## Python & Pip
#(TODO) add check if python3 is already installed 
echo "Install Python & Pip? [Y,n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
  sudo apt-get update
  sudo apt install -y python3-pip
fi

## Git
echo "Install Git? [Y,n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
  sudo apt install -y git-all
fi
echo "Generate new Github SSH key? [Y,n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
  echo "Enter email"
  read email
  ssh-keygen -t ed25519 -C $email
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  cat ~/.ssh/id_ed25519.pub
fi

## VS Code
echo "Install VS Code? [Y,n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
  sudo apt-get update
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
  sudo apt install -y code
  sudo apt update
  sudo apt upgrade
fi

## Kazam Screen Recorder
echo "Install Kazam? [Y,n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
  sudo apt install -y kazam python3-cairo python3-xlib
fi

## Slack
echo "Install Slack? [Y,n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
  sudo snap install slack
fi

## Zotero
## ROS
sudo sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros2-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y python3-vcstool python3-colcon-common-extensions

## VLC
## Spotify

## Add to .bashrc
#

## Pull custom tools
# git clone

## Get Open Robotics Workspaces
mkdir -p buoy_ws/src
git clone https://github.com/osrf/buoy_entrypoint.git
cd buoy_ws/src && vcs import < ~/buoy_entrypoint/buoy_all.yaml
cd

mkdir -p gazebo/garden_ws/src
cd gazebo/garden_ws
wget https://raw.githubusercontent.com/gazebo-tooling/gazebodistro/master/collection-garden.yaml
vcs import src < collection-garden.yaml
cd

mkdir maintenance_ws
cd maintenance_ws
git clone https://github.com/ros-visualization/interactive_markers.git
git clone https://github.com/ros2/ros1_bridge.git
git clone https://github.com/ros2/rosidl.git
git clone https://github.com/ros2/rosidl_python.git
git clone https://github.com/ros2/ros_testing.git
git clone https://github.com/ros2/rpyutils.git
git clone https://github.com/ros-visualization/rqt.git
git clone https://github.com/ros-visualization/rqt_reconfigure.git
git clone https://github.com/ros2/spdlog_vendor.git
cd

# mkdir -p ogre_ws/src

mkdir -p ros2/humble_ws/src

# mkdir -p uuv_ws/src

mkdir space_ros_ws
cd space_ros_ws
git clone https://github.com/space-ros/demos.git
git clone https://github.com/space-ros/docker.git
git clone https://github.com/space-ros/simulation.git
cd


## Docker (https://docs.docker.com/engine/install/ubuntu/)
echo "Install Docker Engine? [Y,n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo docker run hello-world

  # Rocker
  sudo apt-get install -y python3-rocker

  # NVIDIA Docker (https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)
  distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
  sudo apt-get update
  sudo apt-get install -y nvidia-docker2
  sudo systemctl restart docker
  sudo docker run --rm --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi

  # Linux Postinstall steps (https://docs.docker.com/engine/install/linux-postinstall/)
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
  docker run hello-world
fi
