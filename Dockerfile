
FROM golang:1.12.7

ENV DEBIAN_FRONTEND noninteractive

ENV API_PORT 5002
ENV GATEWAY_PORT 8080
ENV SWARM_PORT 4001

EXPOSE ${SWARM_PORT}
EXPOSE ${API_PORT}
EXPOSE ${GATEWAY_PORT}

#Install
RUN go get -u github.com/ipfs/ipfs-update \
    && ipfs-update install latest \
    && ipfs init

RUN ipfs config Addresses.API /ip4/0.0.0.0/tcp/${API_PORT}

RUN ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/${GATEWAY_PORT}

ENTRYPOINT ["ipfs"]
CMD ["daemon"]
