# docker-image

<!-- Badges -->
[![CI to Docker Hub](https://github.com/markcaudill/docker-image/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/markcaudill/docker-image/actions/workflows/ci.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/markcaudill/image)](https://hub.docker.com/repository/docker/markcaudill/image)
[![Docker Image Size](https://img.shields.io/docker/image-size/markcaudill/image/latest?label=latest)](https://hub.docker.com/repository/docker/markcaudill/image/tags?page=1&ordering=last_updated)
<!-- /Badges -->

## Description

Prints `NOP` to the terminal.

To use this repo as a template, clone it to `docker-<your_image_name>`, then run
`config-repo.sh`. This template assumes GitHub as the VCS, Docker Hub as the
image registry, and `latest` as the primary image tag.

In order for the workflow to be able to push to Docker Hub, ensure you setup
the repository secrets `DOCKER_HUB_USERNAME` and `DOCKER_HUB_ACCESS_TOKEN`.

## Usage

### Docker

```console
$ docker run --rm -it docker.io/markcaudill/image
+ env
HOSTNAME=a2f37b0c841e
PWD=/
HOME=/root
TERM=xterm
SHLVL=1
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
_=/usr/bin/env
+ echo NOP
NOP
```

### Podman

```console
$ podman run --rm -it docker.io/markcaudill/image
+ env
HOSTNAME=f6f51d497d41
PWD=/
container=podman
HOME=/root
TERM=xterm
SHLVL=1
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
_=/usr/bin/env
+ echo NOP
NOP
```
