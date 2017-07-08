#!/bin/bash 

#if [ "$EUID" -ne 0 ]; then
#	echo "Please run as root (with sudo)"
#	exit
#fi

SETUP_DIR="$HOME/gpu-setup"
mkdir -p $SETUP_DIR
cd $SETUP_DIR

# install python libraries
sudo apt-get -y install python3-numpy python3-dev python3-wheel python3-mock python3-matplotlib python3-pip nvidia-cuda-toolkit

# install cuda drivers
if [ ! -f "cuda-repo-ubuntu1604_8.0.61-1_amd64.deb" ]; then 
	wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
fi
sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo apt-get update
sudo apt-get -y install cuda

echo "Setup requires a reboot to continue."
echo "The VM will reboot now. Login after it restarts and continue installation from part2."

sudo reboot

