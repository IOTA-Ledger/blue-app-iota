#!/bin/bash

## Functions
_bold=$(tput bold)
_reset=$(tput sgr0)

_red=$(tput setaf 1)
_green=$(tput setaf 2)
_yellow=$(tput setaf 3)

function print_ok   { printf "${_bold}${_green}%s${_reset}\n" "$@"; }
function print_err  { printf "${_bold}${_red}%s${_reset}\n" "$@"; }
function print_warn { printf "${_bold}${_yellow}%s${_reset}\n" "$@"; }

## Linux Distribution and Version Check
print_ok "Installing development environment for blue-app-iota..."

if ! type "gawk" &> /dev/null; then
  print_err "ERROR: gawk is missing! If you're on Ubuntu, please run 'sudo apt install -y gawk'"
  exit 1
fi

linux_distr=`gawk -F= '/^NAME/{print $2}' /etc/os-release`
linux_codename=`gawk -F= '/^VERSION_CODENAME/{print $2}' /etc/os-release`
if [ ${linux_distr} != '"Ubuntu"' ];
then
    print_err "ERROR: This script was created for Ubuntu only! Exiting..."
    exit 1
fi

if [ ${linux_codename} != 'artful' ];
then
    print_err "ERROR: This script was tested under Ubuntu Artful Aardvark only! Exiting..."
    exit 1
fi

## Variables
BLUE_APP_IOTA_PY_VIRT_ENV=`realpath .pyenv`
export BOLOS_SDK=`realpath ../nanos-secure-sdk`
export BOLOS_ENV=`realpath ../bolos-devenv`
DIR_ARM_GCC=${BOLOS_ENV}/gcc-arm-none-eabi-5_3-2016q1/
DIR_CLANG=${BOLOS_ENV}/clang-arm-fropi/

print_ok "Updating Packages..."
sudo apt update && sudo apt dist-upgrade -y

print_ok "Installing build-essential, libc6, libudev, libusb and Python3 virtual environment..."
sudo apt install -y build-essential libc6-i386 libc6-dev-i386 libudev-dev libusb-1.0-0-dev virtualenv python3-dev python3-pip python3-virtualenv python3-venv

if [ ! -d ${BOLOS_ENV} ]; then
    mkdir -p ${BOLOS_ENV}
fi

if [ ! -d ${DIR_ARM_GCC} ]; then
    print_ok "Downloading \"gcc-arm-none-eabi-5_3-2016q1\"..."
    wget -N https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q1-update/+download/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2 -P ${BOLOS_ENV}/

    print_ok "Unzipping \"gcc-arm-none-eabi-5_3-2016q1\"..."
    tar xf ${BOLOS_ENV}/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2 -C ${BOLOS_ENV}/
fi

if [ ! -d ${DIR_CLANG} ]; then
    print_ok "Downloading \"clang+llvm-4.0.0\"..."
    wget -N http://releases.llvm.org/4.0.0/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.10.tar.xz -P ${BOLOS_ENV}/

    print_ok "Unzipping \"clang+llvm-4.0.0\"..."
    tar xf ${BOLOS_ENV}/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.10.tar.xz -C ${BOLOS_ENV}/
    mv ${BOLOS_ENV}/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.10 ${BOLOS_ENV}/clang-arm-fropi
fi

if [ -d ${BOLOS_SDK} ]; then
   print_ok "Updating nanos-secure-sdk..."
   cd ${BOLOS_SDK}
   git pull origin master
   git checkout tags/nanos-141
else
   print_ok "Downloading nanos-secure-sdk..."
   cd ..
   git clone https://github.com/LedgerHQ/nanos-secure-sdk.git
   git checkout tags/nanos-141
fi

## Adding environment variables t0 .bashrc
if grep -q '^export BOLOS_SDK=' ~/.bashrc
then
   # change BOLOS_SDK
   print_ok "Updating \"BOLOS_SDK\" environment variable in .bashrc..."
   sed -i -e "s;.*export BOLOS_SDK=.*;export BOLOS_SDK=\"${BOLOS_SDK}\";" ~/.bashrc
else
   # add BOLOS_SDK
   print_ok "Adding \"BOLOS_SDK\" environment variable to .bashrc..."
   sed -i -e "$ a\export BOLOS_SDK=\"${BOLOS_SDK}\"" ~/.bashrc
fi

if grep -q '^export BOLOS_ENV=' ~/.bashrc
then
   # change BOLOS_ENV
   print_ok "Updating \"BOLOS_ENV\" environment variable in .bashrc..."
   sed -i -e "s;.*export BOLOS_ENV=.*;export BOLOS_ENV=\"${BOLOS_ENV}\";" ~/.bashrc
else
   # add BOLOS_ENV
   print_ok "Adding \"BOLOS_ENV\" environment variable to .bashrc..."
   sed -i -e "$ a\export BOLOS_ENV=\"${BOLOS_ENV}\"" ~/.bashrc
fi

print_ok "Creating python virtual environment..."
python3 -m venv ${BLUE_APP_IOTA_PY_VIRT_ENV}
. ${BLUE_APP_IOTA_PY_VIRT_ENV}/bin/activate
pip3 install setuptools --upgrade
pip3 install wheel
#pip3 install ledgerblue    # This doesn't work at the moment => Better use the git repo!
SECP_BUNDLED_EXPERIMENTAL=1 pip3 --no-cache-dir install --no-binary secp256k1 secp256k1
pip3 install git+https://github.com/LedgerHQ/blue-loader-python.git

print_ok "Adding user to the \"plugdev\" group..."
sudo adduser $USER plugdev

print_ok "Installing udev rules for ledger nano S..."
# Additional Tags (if ledger is no recognized) => TAG+="uaccess", TAG+="udev-acl" OWNER="<UNIX username>"
sudo bash -c "echo 'SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2581\", ATTRS{idProduct}==\"1b7c\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2581\", ATTRS{idProduct}==\"2b7c\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2581\", ATTRS{idProduct}==\"3b7c\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2581\", ATTRS{idProduct}==\"4b7c\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2581\", ATTRS{idProduct}==\"1807\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2581\", ATTRS{idProduct}==\"1808\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2c97\", ATTRS{idProduct}==\"0000\", MODE=\"0660\", GROUP=\"plugdev\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2c97\", ATTRS{idProduct}==\"0001\", MODE=\"0660\", GROUP=\"plugdev\"' >/etc/udev/rules.d/20-hw1.rules"
sudo udevadm trigger
sudo udevadm control --reload-rules

print_ok "...Installing development environment for blue-app-iota done!"
print_warn "Please restart to apply changes!"
