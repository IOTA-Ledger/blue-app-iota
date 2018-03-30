#!/bin/bash

_bold=$(tput bold)
_reset=$(tput sgr0)

_red=$(tput setaf 1)
_green=$(tput setaf 2)
_yellow=$(tput setaf 3)

function print_ok   { printf "${_bold}${_green}%s${_reset}\n" "$@"; }
function print_err  { printf "${_bold}${_red}%s${_reset}\n" "$@"; }
function print_warn { printf "${_bold}${_yellow}%s${_reset}\n" "$@"; }

print_ok "Installing development environment for blue-app-iota..."

if [ `gawk -F= '/^NAME/{print $2}' /etc/os-release` != '"Ubuntu"' ];
then
    print_err "ERROR: This script was created for Ubuntu only! Exiting..."
    exit 1
fi

if [ `gawk -F= '/^VERSION_CODENAME/{print $2}' /etc/os-release` != 'artful' ];
then
    print_err "ERROR: This script was tested under Ubuntu Artful Aardvark only! Exiting..."
    exit 1
fi

print_ok "Updating Packages..."
sudo apt update && sudo apt dist-upgrade

print_ok "Installing LLVM, Clang and Python3 virtual environment..."
sudo apt install clang-5.0 llvm5.0 libc6-i386 libc6-dev-i386 gcc-arm-none-eabi build-essential libudev-dev libusb-1.0-0-dev virtualenv npm python3-dev libudev-dev libusb-1.0-0-dev python3-pip python3-virtualenv python3-venv

export BLUE_APP_IOTA_PY_VIRT_ENV=`realpath .pyenv`
export BOLOS_SDK=`realpath ../nanos-secure-sdk`

if [ -d ${BOLOS_SDK} ]; then
   print_ok "Update nanos-secure-sdk..."
   cd ${BOLOS_SDK}
   git pull origin master
   git checkout tags/nanos-141
else
   print_ok "Download nanos-secure-sdk..."
   cd ..
   git clone https://github.com/LedgerHQ/nanos-secure-sdk.git
   git checkout tags/nanos-141
fi

if grep -q '^export BOLOS_SDK=' ~/.bashrc
then
   # change BOLOS_SDK
   print_ok "Update \"BOLOS_SDK\" environment variable in .bashrc..."
   sed -i -e "s;.*export BOLOS_SDK=.*;export BOLOS_SDK=\"${BOLOS_SDK}\";" ~/.bashrc
else
   # add BOLOS_SDK
   print_ok "Add \"BOLOS_SDK\" environment variable to .bashrc..."
   sed -i -e "$ a\export BOLOS_SDK=\"${BOLOS_SDK}\"" ~/.bashrc
fi

print_ok "Create python virtual environment..."
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
# Additional Tags => TAG+="uaccess", TAG+="udev-acl" OWNER="<UNIX username>"
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
