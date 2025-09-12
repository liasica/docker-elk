#!/usr/bin/env bash

LATEST=`curl -s https://api.github.com/repos/liasica/docker-elk/releases/latest | grep tag_name | cut -d ':' -f 2 | tr -d '\"' | tr -d ' ' | xargs -I {} echo {} | tr -d ','`
# LATEST=`cat latest | grep tag_name | cut -d ':' -f 2 | tr -d '\"' | tr -d ' ' | xargs -I {} echo {} | tr -d ','`
VERSION=`echo $LATEST | cut -d '-' -f 1`

echo "Latest $LATEST version is $VERSION"
echo "license: ${ELASTIC_LICENSE}"
echo "downloading crack files..."

echo "downloading from https://github.com/liasica/docker-elk/releases/download/$LATEST/x-pack-core-$VERSION.crack.jar"
curl -L -o "/usr/share/elasticsearch/modules/x-pack-core/x-pack-core-${VERSION}.jar" "https://github.com/liasica/docker-elk/releases/download/$LATEST/x-pack-core-$VERSION.crack.jar"

echo "downloading from https://github.com/liasica/docker-elk/releases/download/$LATEST/${ELASTIC_LICENSE}.json"
curl -L -o /usr/share/elasticsearch/license.json "https://github.com/liasica/docker-elk/releases/download/$LATEST/${ELASTIC_LICENSE}.json"
