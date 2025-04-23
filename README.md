# Metadise Container Image

This repository houses machinery for building a container image of the
program *Metadise*, details of which can be found on its [website](https://people.bath.ac.uk/chsscp/teach/metadise.bho/) and in the [scientific paper](https://doi.org/10.1039/FT9969200433)
describing the program.

The `Dockerfile` here builds a container image housing Metadise. The
image is intended to be used as a container-image analogue of the
Metadise executable.


## Obtaining an image

Images can be found in the Packages section of this GitHub project.
Commands are provided there to pull a specific version to your local
instance of docker, e.g.
```
docker pull ghcr.io/psdi-uk/metadise-container/metadise:v0.0.1
```


## Usage

It is intended that the image be used similarly to the
Metadise binary executable. An example command is:
```
docker run -v ${PWD}:/data metadise:v0.0.1
```
This command assumes that the image is named 'metadise:v0.0.1' and that the
current directory contains your Metadise input files.
Upon instigating this command, the container will
execute Metadise in the current directory, and Metadise output files
will be created in the directory. Upon completion of the Metadise
executable the container will terminate.


## Building the image

If you have access to the Metadise source code then you can use the `Dockerfile`
here to build the image locally. To do this the command is:
```
docker build -t metadise .
```
where it is assumed that:
1. the image is to be named `metadise`
2. the `Dockerfile` file is in the current directory
3. the source code for Metadise is housed in the subdirectory `metadise_source`

*Note that the source code for Metadise is not provided in this repository.* To
obtain this source code please see Metadise's documentation, links to which
are provided above.


## License

The code in this repository is provided under the conditions
described in the `LICENSE` file in this repository. However, while some of this
code describes container images or processes to build container images,
the software license applicable to these container images will in general not be the
same as `LICENSE`. This is because a container image typically includes binaries
and source code from many pieces of software; the software license for a
container image depends on the licenses of its constituent software.
This should be kept in mind when using any container image linked to this
repository, or any container image built using code in this repository.


# Notes for developers

