ARG ELASTIC_VERSION

# https://www.docker.elastic.co/
FROM docker.elastic.co/elasticsearch/elasticsearch:${ELASTIC_VERSION:-9.1.3}

ARG ELASTIC_LICENSE
ENV ELASTIC_LICENSE=${ELASTIC_LICENSE:-platinum}

USER root

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY crack.sh /usr/local/bin/crack.sh

RUN chmod +x /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/crack.sh \
    && /usr/local/bin/crack.sh

USER elasticsearch

# Add your elasticsearch plugins setup here
# Example: RUN elasticsearch-plugin install analysis-icu

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
