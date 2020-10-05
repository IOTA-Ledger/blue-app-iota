ARG DEVICE=nanos

# Stage 1: build the IOTA application 
FROM wollac/ledger-bolos AS build-app

ARG DEVICE

COPY dev/sdk/${DEVICE}-secure-sdk/ /usr/sdk/
ENV BOLOS_SDK /usr/sdk

ENV BOLOS_ENV /opt/bolos

COPY Makefile /usr/project/
COPY src/ /usr/project/src/
COPY glyphs/ /usr/project/glyphs/
COPY icons/ /usr/project/icons/

WORKDIR /usr/project/

RUN make
# don't run load, but store it as a script
RUN make -n load > load.sh

# Stage 2: build ledgerblue
FROM python:3.8-slim AS build-ledgerblue

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    gcc python-dev libudev-dev libusb-1.0-0-dev \
    && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir ledgerblue

# Stage 3: the final container
FROM python:3.8-slim

ARG DEVICE

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libusb-1.0-0 \
    && rm -rf /var/lib/apt/lists/*

# copy ledgerblue and its dependencies
COPY --from=build-ledgerblue /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages

WORKDIR /root/

COPY --from=build-app /usr/sdk/icon3.py /usr/sdk/icon3.py

COPY --from=build-app /usr/project/icons/${DEVICE}_app_iota.gif icons/
COPY --from=build-app /usr/project/load.sh .
COPY --from=build-app /usr/project/debug/app.map debug/
COPY --from=build-app /usr/project/bin/app.hex bin/

ENTRYPOINT ["sh", "/root/load.sh"]
