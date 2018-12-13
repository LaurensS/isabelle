# Isabelle docker image

A docker image with isabelle installed for CI builds.

## Usage

To run the container with the current working directory mounted:

    docker run --rm -it -v ${PWD}:/data laurenss/isabelle isabelle build -d. SessionName
