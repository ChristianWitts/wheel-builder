#!/usr/bin/env sh

TARGET_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")"/target && pwd)"

docker build -t cross-compile .

while read REQ; do
    docker run --rm -v ${TARGET_PATH}:/usr/src/target cross-compile "${REQ}"
done <requirements.txt