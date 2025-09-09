ARG ELASTIC_VERSION=9.1.3

FROM docker.elastic.co/elasticsearch/elasticsearch:${ELASTIC_VERSION} AS baseline

FROM bellsoft/liberica-openjdk-debian:17

ARG ELASTIC_VERSION
ARG HTTP_PROXY
ARG HTTPS_PROXY
ENV ELASTIC_VERSION=${ELASTIC_VERSION}

WORKDIR /crack

COPY --from=baseline /usr/share/elasticsearch/lib /usr/share/elasticsearch/lib
COPY --from=baseline /usr/share/elasticsearch/modules/x-pack-core /usr/share/elasticsearch/modules/x-pack-core
COPY build_crack_jar.sh /crack

RUN apt update && apt install -y zip

CMD [ "bash", "build_crack_jar.sh" ]
