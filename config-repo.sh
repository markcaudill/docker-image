#!/bin/bash -x

set -eu -o pipefail

DOCKER_REPOSITORY=
GITHUB_USERNAME=
MAINTAINER=

if [[ -z "${DOCKER_REPOSITORY}" ]]; then
    echo -n "Docker repository [DOCKER_REPOSITORY]: "
    read -r DOCKER_REPOSITORY
fi

if [[ -z "${GITHUB_USERNAME}" ]]; then
    echo -n "GitHub username [GITHUB_USERNAME]: "
    read -r GITHUB_USERNAME
fi

if [[ -z "${MAINTAINER}" ]]; then
    echo -n "Maintainer [MAINTAINER]: "
    read -r MAINTAINER
fi

github_workflow_badge() {
    local github_username="${1}"; shift
    local github_repo="${1}"; shift
    local workflow_name="${1:-ci}"; shift
    local branch="${1:-main}"; shift
    local url="https:\/\/github\.com"
    url="${url}\/${github_username}"
    url="${url}\/${github_repo}"
    url="${url}\/actions\/workflows\/${workflow_name}.yml"
    local badge_url="${url}\/badge\.svg\?branch=${branch}"
    echo "\[!\[CI to Docker Hub\](${badge_url})\](${url})"
}

docker_image_page() {
    local docker_repo="${1}"; shift
    local image_name="${1}"; shift
    local url="https:\/\/hub\.docker\.com\/repository\/docker"
    url="${url}\/${docker_repo}\/${image_name}"
    echo "${url}"
}

docker_image_tags_page() {
    local docker_repo="${1}"; shift
    local image_name="${1}"; shift
    local url
    url="$(docker_image_page "${docker_repo}" "${image_name}")"
    echo "${url}\/tags?page=1&ordering=last_updated"
}

docker_pulls_badge() {
    local docker_repo="${1}"; shift
    local image_name="${1}"; shift
    local badge_url="https:\/\/img\.shields\.io\/docker\/pulls"
    badge_url="${badge_url}\/${docker_repo}\/${image_name}"
    local image_url
    image_url="$(docker_image_page "${docker_repo}" "${image_name}")"
    echo "\[\!\[Docker Pulls\](${badge_url})](${image_url})"
}

docker_size_badge() {
    local docker_repo="${1}"; shift
    local image_name="${1}"; shift
    local badge_url="https:\/\/img\.shields\.io\/docker\/image-size"
    badge_url="${badge_url}\/${docker_repo}\/${image_name}"
    badge_url="${badge_url}\/latest\?label=latest"
    local image_tags_url
    image_tags_url="$(docker_image_tags_page "${docker_repo}" "${image_name}")"
    echo "\[\!\[Docker Image Size\](${badge_url})](${image_tags_url})"
}

sed -i "s/LABEL maintainer=.*/LABEL maintainer=\"${MAINTAINER}\"/" Dockerfile

sed -i "s/REPO = .*/REPO = ${DOCKER_REPOSITORY}/" Makefile

image_name="$(basename "$(pwd)" | awk -F'-' '{print $NF}')"

badge_contents="<!-- Badges -->"
badge_contents="${badge_contents}\n$(github_workflow_badge "${GITHUB_USERNAME}" "docker-${image_name}")"
badge_contents="${badge_contents}\n$(docker_pulls_badge "${DOCKER_REPOSITORY}" "${image_name}")"
badge_contents="${badge_contents}\n$(docker_size_badge "${DOCKER_REPOSITORY}" "${image_name}")"
badge_contents="${badge_contents}\n<!-- \/Badges -->"
sed -i "/<!-- Badges -->/,/<!-- \/Badges -->/c${badge_contents}" README.md
