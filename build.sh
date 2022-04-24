#!/bin/bash

# Copyright 2022 IOTA-Foundation
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# get real path of script
rpath="$( dirname $( readlink -f $0 ) )"
cd $rpath

# use the latest images
IMAGE_BUILD="ghcr.io/ledgerhq/ledger-app-builder/ledger-app-builder:latest"
IMAGE_SPECULOS="ghcr.io/ledgerhq/speculos:latest"

function error {
    echo "error: $1"
    exit 1
}

function usage {
    echo "usage: $0 [-h|--help] [-d|--debug] [-m|--model (nanos*|nanox|nanosplus)] [-l|--load] [-s|--speculos] [-c|--cxlib 1.0.2]"
    echo "-d|--debug:    build app with DEBUG=1"
    echo "-m|--model:    nanos (default), nanox, nanosplus"
    echo "-l|--load:     load app to device"
    echo "-s|--speculos: run app after building with the speculos simulator"
    echo "-c|--cxlib:    don't autodetect cx-lib version (for speculos)"
    exit 1
}

# pull and tag image 
function pull_image {
    docker image pull "$1" && \
    docker image tag "$1" "$2"
}

# check if we are using root/sudo 
whoami="$( whoami )"

[[ "$whoami" == "root" ]] && {
    echo "please don't run the script as root or with sudo."
    return 1
}

# and if the user has permissions to use docker
grep -q docker <<< "$( id -Gn $whoami )" || {
    echo "user $whoami not in docker group."
    echo "to add the user you can use (on Ubuntu):"
    echo
    echo "sudo usermod -a -G docker $whoami"
    echo
    echo "after adding, logout and login is required"
    return 1
}

# let's parse argments
device="nanos" # default
nobuild=0
load=0
speculos=0
debug=0
cxlib=""
while (( $# ))
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
    "-c" | "--cxlib")
        shift
        cxlib="$1"
        ;;
    "-d" | "--debug")
        debug=1
        ;;
    *)
        error "unknown parameter: $1"
        ;;
    esac
    shift

done

# not supported combinations of flags?
(( $speculos )) && (( $load )) && error "-l and -s cannot be used at the same time"

# map device to model (different in speculos)
case "$device" in
    nanos )
        model="nanos"
        ;;
    nanox )
        model="nanox"
        ;;
    nanosplus )
        model="nanosp"
        ;;
    *)
        error "unknown device: $device"
        ;;
esac

# find SDK version number
BOLOS_SDK="$device-secure-sdk"

[ ! -d "./dev/sdk/$device-secure-sdk" ] && error "sdk not found. Are the submodules initialized?"

# get sdk version from sdk
sdk="$( grep '^#define BOLOS_VERSION' ./dev/sdk/${device}-secure-sdk/include/bolos_version.h | awk '{ print $ 3}' | tr -d '"' )"

# if the first character is a digit, we are convinced it's a valid version number
grep -q '^[[:digit:]]' <<< "$sdk" || error "$sdk not a valid version"

# find the fitting cxlib of speculos
[ -z "$cxlib" ] && {
    # we assume we have the same cxlib as the sdk
    cxlib="$sdk"

    while [ ! -z "$cxlib" ]
    do
        cxlib_fn="./dev/speculos/speculos/cxlib/$model-cx-$cxlib.elf"
        [ -f "$cxlib_fn" ] && {
            # we found something matching
            break
        }
        # we iteratively remove the last component of the version
        # 1.0.2 -> 1.0
        # 1.0 -> 1
        # 1 -> ""
        cxlib="$( awk -F'.' 'BEGIN{OFS="."} NF{NF--};1' <<< "$cxlib" )"
    done
}

# if it is zero, we didn't find something matching
[ -z "$cxlib" ] && error "no fitting cxlib found. Try -c|--cxlib."

# yay, finally we can start
echo "device $device selected, sdk $sdk found, using cx-lib $cxlib"

# build the app
# pull and tag image
pull_image \
    "$IMAGE_BUILD" \
    ledger-app-builder || error "couldn't pull image"

build_flags=""

# if speculos requested, add the flag
(( $speculos )) && {
    build_flags+="SPECULOS=1 "
}

# if debug requested, add the flag
(( $debug )) && {
    build_flags+="DEBUG=1 "
}

# default make cmd
cmd="make clean && $build_flags make "
extra_args=""

# we have to map usb into the docker when loading the app
(( $load )) && {
    extra_args+="--privileged -v /dev/bus/usb:/dev/bus/usb "
    cmd+="&& make load"
}

docker run \
    -e BOLOS_SDK="/app/dev/sdk/$BOLOS_SDK" $extra_args \
    --rm -v "$rpath:/app" \
    ledger-app-builder \
        bash -c "$cmd" || error "building failed"

(( $load )) && {
    # we are finished
    exit 0
}

# run the simulator
(( $speculos )) && {
    # pull and tag image
    pull_image \
        "$IMAGE_SPECULOS" \
        speculos || error "couldn't pull image"

    # default Ledger seed
    seed="glory promote mansion idle axis finger extra february uncover one trip resource lawn turtle enact monster seven myth punch hobby comfort wild raise skin"

    [ -f "testseed.txt" ] && { seed="$( cat "testseed.txt" )"; }

    [ ! -f "./bin/app.elf" ] && {
        error "binary missing. Something went wrong"
    }

    # get app name and version from Makefile
    # remove only whitespaces before and after =
    eval $( grep '^APPNAME' Makefile | sed -e ':loop;s/ =/=/g;s/= /=/g;t loop' )
    # replace () to {} before eval
    eval $( grep '^APPVERSION' Makefile | tr -d ' ' | tr '()' '{}' )

    { sleep 10; echo -e "\nPlease open your browser: http://localhost:5000\n"; echo; } &

    docker run \
        -v "$rpath:/speculos/apps" \
        -p 9999:9999 \
        -p 5000:5000 \
        -e SPECULOS_APPNAME="$APPNAME:$APPVERSION" \
        --rm \
        -it \
        speculos \
            --apdu-port 9999 \
            --display headless \
            --seed "$seed" \
            --sdk "$cxlib" \
            -m "$model" /speculos/apps/bin/app.elf
}

        
