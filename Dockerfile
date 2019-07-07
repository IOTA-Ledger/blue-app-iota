ARG DEVICE=nanos

# Stage 1: build the IOTA application 
FROM zondax/ledger-docker-bolos AS build-app

ARG DEVICE

COPY dev/sdk/${DEVICE}-secure-sdk/ /user/sdk/
ENV BOLOS_SDK /user/sdk

ENV BOLOS_ENV /opt/bolos

COPY Makefile /user/project/
COPY src/ /user/project/src/
COPY glyphs/ /user/project/glyphs/
COPY icons/ /user/project/icons/

WORKDIR /user/project/

RUN make
# don't run load, but store it as a script
RUN make -n load > load.sh

# Stage 2: build ledgerblue
FROM python:3.7-slim AS build-ledgerblue

RUN apt-get update \
    && apt-get install -y gcc python-dev libudev-dev libusb-1.0-0-dev
RUN pip install ledgerblue

# Stage 3: the final container
FROM python:3.7-slim

ARG DEVICE

RUN apt-get update \
    && apt-get install -y --no-install-recommends libusb-1.0-0 \
    && rm -rf /var/lib/apt/lists/*

# copy ledgerblue
COPY --from=build-ledgerblue /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.7/site-packages

WORKDIR /root/

COPY --from=build-app /user/sdk/icon.py /user/sdk/icon.py

COPY --from=build-app /user/project/icons/${DEVICE}_app_iota.gif icons/
COPY --from=build-app /user/project/load.sh .
COPY --from=build-app /user/project/debug/app.map debug/
COPY --from=build-app /user/project/bin/app.hex bin/

ENTRYPOINT ["sh", "/root/load.sh"]
