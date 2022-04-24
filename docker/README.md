# docker

With this docker files you can:
- run a simulator with a Leder Nano S or X
- compile the app and load it on a Nano S*

*: Loading an app on a Nano X outside the Ledger app-store is only supported with special developer versions that only could be borrowed from Ledger (with NDA). But for testing purposes, the Nano X is supported in the simulator.

# Building

For both cases you always have to build the docker image first.

Before builing the images, install docker and add your user to the docker user-group:

```
$ sudo apt install docker.io

# add to docker group (logout and login required). 
$ sudo usermod -A docker $your_username
```


Clone the repository and run the build-script

```
$ git clone https://github.com/iotaledger/app-iota-legacy
$ cd app-iota-legacy
$ git submodule init
$ git submodule update --recursive
$ cd docker
$ sudo ./build_load_app.sh [-m (nanos*|nanox|nanosplus)]
```


# Running the IOTA app in the simulator

After building the Docker container, the app can be run using following script:

```
$ sudo ./run_simulator.sh [-m (nanos*|nanox|nanosplus)]
```

The `-m` argument can be used to switch between Nano S/X and Nano S Plus. The default is `nanos`.

After starting, the simulator listens on port 9999 and can be used without restrictions with the `ledger-iota.rs` library.

An emulated display can be viewed by opening the url `http://localhost:5000` in a webbrowser.


# Loading the IOTA app on a Ledger Nano S

To compile and load the IOTA app on a real Ledger Nano S use the following script:

```
$ sudo ./load_build_app.sh -m nanos -l
```

