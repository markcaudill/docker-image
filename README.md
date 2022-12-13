# docker-image

<!-- Badges -->
[![CI to Docker Hub](https://github.com/markcaudill/docker-image/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/markcaudill/docker-image/actions/workflows/ci.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/markcaudill/image)](https://hub.docker.com/repository/docker/markcaudill/image)
[![Docker Image Size](https://img.shields.io/docker/image-size/markcaudill/image/latest?label=latest)](https://hub.docker.com/repository/docker/markcaudill/image/tags?page=1&ordering=last_updated)
<!-- /Badges -->

## Template Usage

To use this repository as a template,
[clone it](https://github.com/markcaudill/docker-image/generate)
to `docker-<your_image_name>`, then run `config-repo.sh`. This template
assumes GitHub as the VCS, Docker Hub as the image registry, and `latest`
as the primary image tag.

You can also use the [GitHub CLI](https://cli.github.com/)

```console
$ gh repo create --public --template markcaudill/docker-image docker-example
$ gh repo clone markcaudill/docker-example
Cloning into 'docker-example'...
remote: Enumerating objects: 13, done.
remote: Counting objects: 100% (13/13), done.
remote: Compressing objects: 100% (11/11), done.
remote: Total 13 (delta 0), reused 7 (delta 0), pack-reused 0
Receiving objects: 100% (13/13), 5.11 KiB | 5.11 MiB/s, done.
```

In order for the workflow to be able to push to Docker Hub, ensure you setup
the repository secrets `DOCKER_HUB_USERNAME` and `DOCKER_HUB_ACCESS_TOKEN` by
visiting `https://github.com/<username>/<repository>/settings/secrets/actions`.

## Example Description

Prints `NOP` to the terminal.

## Example Image Usage

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
