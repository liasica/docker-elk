ARG ELASTIC_VERSION

FROM docker.elastic.co/elasticsearch/elasticsearch:${ELASTIC_VERSION:-9.1.3} AS baseline

FROM bellsoft/liberica-openjdk-debian:21

ARG ELASTIC_VERSION
ARG HTTP_PROXY
ARG HTTPS_PROXY
ENV ELASTIC_VERSION=${ELASTIC_VERSION}

WORKDIR /x-pack-core

COPY --from=baseline /usr/share/elasticsearch/lib /usr/share/elasticsearch/lib
COPY --from=baseline /usr/share/elasticsearch/modules/x-pack-core /usr/share/elasticsearch/modules/x-pack-core
COPY build.sh /x-pack-core

RUN apt update && apt install -y zip

CMD [ "bash", "build.sh" ]
