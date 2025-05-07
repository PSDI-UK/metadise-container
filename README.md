# Metadise Container Images

This repository houses machinery for building container images of the program *Metadise*.
Details regarding Metadise can be found on its [website](https://people.bath.ac.uk/chsscp/teach/metadise.bho/)
and in the [scientific paper](https://doi.org/10.1039/FT9969200433) describing the program.

The `Dockerfile` here builds a container image housing Metadise. The image is intended to
be used as a container-image analogue of the Metadise executable.


## Obtaining an image

Images can be found in the [Packages](https://github.com/orgs/PSDI-UK/packages?repo_name=metadise-container)
section of this GitHub project. Commands are provided there to pull a specific
version to your local instance of docker, e.g.
```
docker pull ghcr.io/psdi-uk/metadise-container/metadise:v0.0.3
```


## Usage

It is intended that the image be used similarly to the
Metadise binary executable. An example command is:
```
docker run -v ${PWD}:/data ghcr.io/psdi-uk/metadise-container/metadise:v0.0.3
```
This command assumes that the current directory contains your Metadise input files.
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

This repository uses GitHub Actions to implement a CI/CD pipeline which builds, tags
and publishes container images to the GitHub Container Registry linked to this repo
every commit to `main`. The `Dockerfile` is first used to build a Docker-format
container image. This image is in turn used to build a 'sif'-format image (which is
the image format native to Singularity/Apptainer). Both image formats are published
in [Packages](https://github.com/orgs/PSDI-UK/packages?repo_name=metadise-container)

In building the Docker container image the Metadise executable is compiled from
its source code. At the request of the Metadise author, this source code is not
included in this repository in order to keep the code private. Rather, the Metadise
source code is housed in an external private repository which is 'included' in this
repository as a git submodule. This submodule is only 'pulled' into the repo *during* the
CI/CD pipeline, enabling the Metadise source code to be used on the pipeline's runner
to build the Metadise Docker container. In order to be 'included' the submodule during
the pipeline, a personal access token (PAT) is required to access the external
repo housing the Metadise source code. This PAT is a secret for this repository.

