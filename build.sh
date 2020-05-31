#!/usr/bin/env bash

# If this script fails to run on the `docker buildx` line, try:
# - enabling Experimental Features within docker
# - running `docker buildx create` followed by `docker buildx use ...` to create a builder instance

set -ex

function buildAndPush {
    local alpineVersion=$1
    local imagename="alexswilliams/pptp-server"
    local latest="last-build"
    if [ "$2" == "latest" ]; then latest="latest"; fi

    docker buildx build \
        --platform=linux/amd64 \
        --build-arg ALPINE_VERSION=${alpineVersion} \
        --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
        --build-arg VCS_REF=$(git rev-parse --short HEAD) \
        --tag ${imagename}:${alpineVersion} \
        --tag ${imagename}:${latest} \
        --push \
        --file Dockerfile .
}

buildAndPush "3.12.0" "latest"

curl -X POST "https://hooks.microbadger.com/images/alexswilliams/pptp-server/7athI2g_9MllKFtomgGSyHy56q8="
