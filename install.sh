#!/bin/bash

DIRECTORY="${1:-elk}"
echo "Directory is $DIRECTORY"
if [ -d "$DIRECTORY" ] && [ "$(ls -A $DIRECTORY)" ]; then
  echo "Directory $DIRECTORY is not empty. Exiting."
  exit 1
else
  mkdir -p "$DIRECTORY"
fi

LATEST=`curl -s https://api.github.com/repos/liasica/docker-elk/releases/latest | grep tag_name | cut -d ':' -f 2 | tr -d '\"' | tr -d ' ' | xargs -I {} echo {} | tr -d ','`
# LATEST=`cat latest | grep tag_name | cut -d ':' -f 2 | tr -d '\"' | tr -d ' ' | xargs -I {} echo {} | tr -d ','`
VERSION=`echo $LATEST | cut -d '-' -f 1`
echo "Latest version is $VERSION"

echo "Download $VERSION release files..."
curl -s -L -o "$VERSION.tar.gz" "https://github.com/liasica/docker-elk/archive/refs/tags/$LATEST.tar.gz"
echo "Extracting $VERSION.tar.gz to $DIRECTORY..."
tar -xzf "$VERSION.tar.gz" -C "$DIRECTORY" --strip-components=1
rm "$VERSION.tar.gz"

cd $DIRECTORY || exit 1

echo "download $VERSION crack files..."
mkdir -p crack
curl -s -L -o "crack/x-pack-core-$VERSION.crack.jar" "https://github.com/liasica/docker-elk/releases/download/$LATEST/x-pack-core-$VERSION.crack.jar"

read -r -p "Please edit config files, then press Enter to contiune... " -n1 -s

docker compose up setup
docker compose up -d
