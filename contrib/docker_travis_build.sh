#!/usr/bin/env bash
echo "Installing Docker-Ubuntu dependencies"
apt-get update && apt-get install -y gawk libtool git pkg-config udev autoconf autoconf automake build-essential wget sudo
echo "Installing Ledger Dev-environment"
./install_dev_env.sh
echo "Reloading Bash and activating environment"
source .pyenv/bin/activate
source ~/.bashrc
echo "Starting compilation"
make
echo "Done!"
