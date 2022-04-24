#!/bin/bash

# get real path of script
rpath="$( dirname $( readlink -f $0 ) )"

IMAGE="ghcr.io/ledgerhq/speculos:latest"

whoami="$( whoami )"

[[ "$whoami" == "root" ]] && {
    echo "please avoid running the script as root or sudo."
    exit 1
}

grep -q docker <<< "$( id -Gn $whoami )" || {
    echo "user $whoami not in docker group."
    echo "to add the user you can use (on Ubuntu):"
    echo
    echo "sudo usermod -a -G docker $whoami"
    echo
    echo "after adding, logout and login is required"
    exit 1
}

docker pull $IMAGE
docker image tag $IMAGE speculos

function error {
    echo "error: $1"
    exit 1
}

function usage {
    echo "usage: $0 [-h|--help] [-m|--model (nanos|nanox|nanosplus)] [-n|--no-build]"
    echo "-m|--model:    nanos, nanox, nanosplus"
    echo "-n|--no-build: no build before starting the simulator"
    exit 1
}

# default
device="nanos"
nobuild=0
while (($# > 0))
do
    case "$1" in
    "-h" | "--help")
        usage
        ;;
    "-m" | "--model")
        shift
        device="$1"
        ;;
    "-n" | "--no-build")
        nobuild=1
        ;;
    *)
        error "unknown parameter: $1"
        ;;
    esac
    shift

done

case "$device" in
    nanos )
        model="nanos"
        sdk="2.1"
        ;;
    nanox )
        model="nanox"
        sdk="2.0.2"
        ;;
    nanosplus )
        model="nanosp"
        sdk="1.0"
        ;;
    *)
        error "unknown device: $device"
        ;;
esac

echo "device $device selected"

# default Ledger seed
seed="glory promote mansion idle axis finger extra february uncover one trip resource lawn turtle enact monster seven myth punch hobby comfort wild raise skin"

[ -f 'testseed.txt' ] && { seed="$( cat testseed.txt )"; }

(( $nobuild == 0 )) && "$rpath/build_load_app.sh" -s -m $device || error "building app"

[ ! -f "../bin/app.elf" ] && {
    error "binary missing. Please compile first with\n./build_app.sh -m $device"
}

docker run \
    -v "$rpath/..:/speculos/apps" \
    -p 9999:9999 \
    -p 5000:5000 \
    --rm \
    -it \
    speculos \
        --apdu-port 9999 \
        --display headless \
        --seed "$seed" \
        --sdk "$sdk" \
        -m "$model" /speculos/apps/bin/app.elf
        
