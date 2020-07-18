#!/usr/bin/env bash

set -ex

function buildAndPush {
    local alpineVersion=$1
    local imagename="alexswilliams/pptp-server"
    local latest="last-build"
    if [ "$2" == "latest" ]; then latest="latest"; fi

    DOCKER_BUILDKIT=1 docker build \
        --build-arg ALPINE_VERSION=${alpineVersion} \
        --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
        --build-arg VCS_REF=$(git rev-parse --short HEAD) \
        --tag ${imagename}:${alpineVersion} \
        --tag ${imagename}:${latest} \
        --file Dockerfile .

    DOCKER_BUILDKIT=1 docker push ${imagename}:${alpineVersion}
    DOCKER_BUILDKIT=1 docker push ${imagename}:${latest}
}

buildAndPush "3.12.0" "latest"

curl -X POST "https://hooks.microbadger.com/images/alexswilliams/pptp-server/7athI2g_9MllKFtomgGSyHy56q8="
