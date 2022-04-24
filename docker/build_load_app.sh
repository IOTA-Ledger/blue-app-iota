#!/bin/bash

# build-image
IMAGE="ghcr.io/ledgerhq/ledger-app-builder/ledger-app-builder:latest"

whoami="$( whoami )"

[[ "$whoami" == "root" ]] && {
    echo "please avoid running the script as root or sudo."
    exit 1
}

grep -q docker <<< "$( id -Gn $whoami )" || {
    echo "user $( whoami ) not in docker group."
    echo "to add the user you can use (on Ubuntu):"
    echo
    echo "sudo usermod -a -G docker $whoami"
    echo
    echo "after adding, logout and login is required"
    exit 1
}

docker image pull $IMAGE
docker image tag $IMAGE ledger-app-builder

function error {
    echo "error: $1"
    exit 1
}

function usage {
    echo "usage: $0 [-h|--help] [-m|--model (nanos|nanox|nanosplus)] [-b|--build] [-l|--load]"
    echo "-m|--model: nanos, nanox, nanosplus"
    echo "-l|--load:  load app to device"
}

# default
device="nanos"
load=0
speculos=0
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
    "-l" | "--load")
        load=1
        ;;
    "-s" | "--speculos")
        speculos=1
        ;;
    *)
        error "unknown parameter: $1"
        ;;
    esac
    shift

done

case "$device" in
    blue | nanos | nanox | nanosplus)
        BOLOS_SDK="$device-secure-sdk"
        ;;
    *)
        error "unknown device: $device"
        ;;
esac

echo "device $device selected"

extra_args=""
build_flag=""

(( $speculos )) && {
    # this automatically enables debug mode
    build_flag="SPECULOS=1"
}

cmd="make clean && $build_flag make "

(( $load )) && {
    extra_args+="--privileged -v /dev/bus/usb:/dev/bus/usb "
    cmd+="&& make load"
}

docker run -e BOLOS_SDK="/app/dev/sdk/$BOLOS_SDK" $extra_args --rm -ti -v "$( realpath .. ):/app" ledger-app-builder bash #-c "$cmd"

