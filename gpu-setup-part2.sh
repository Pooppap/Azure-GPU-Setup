#!/bin/bash 

#if [ "$EUID" -ne 0 ]; then 
#	echo "Please run as root (use sudo)"
#	exit
#fi

SETUP_DIR="$HOME/gpu-setup"
if [ ! -d $SETUP_DIR ]; then
	echo "Setup directory not found. Did you run part 1?"
	exit
fi
cd $SETUP_DIR

# install cudnn
if [ ! -f "cudnn-8.0-linux-x64-v5.1.tgz" ]; then
    echo "You need to download cudnn-8.0 manually! Specifically, place it at: $SETUP_DIR/cudnn-8.0-linux-x64-v5.1.tgz"
    exit
fi

echo "Uncompressing cudnn"
tar xzvf cudnn-8.0-linux-x64-v5.1.tgz
sudo cp -P cuda/include/cudnn.h /usr/local/cuda/include/
sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64/
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

# update bashrc
echo "Updating bashrc"
echo >> $HOME/.bashrc '
export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64\${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export CUDA_HOME=/usr/local/cuda
'

source $HOME/.bashrc

# create bash_profie
echo "Creating bash_profile"
echo > $HOME/.bash_profile '
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
'

# other Tensorflow dependencies
sudo apt-get -y install libcupti-dev

# upgrade pip
sudo pip3 install --upgrade pip

# install tensorflow 1.0
# export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.2.1-cp35-cp35m-linux_x86_64.whl

#sudo pip3 install -U https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.2.1-cp35-cp35m-linux_x86_64.whl
sudo pip3 install --upgrade tensorflow-gpu
sudo apt-get install jupyter-core
sudo -H pip3 install notebook --upgrade
cd $HOME
mkdir SSL && cd SSL
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mykey.key -out mycert.pem

echo "Script done"

