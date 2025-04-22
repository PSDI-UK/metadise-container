# Stage containing Metadise dependencies
FROM alpine:latest AS base

# Install system dependencies
RUN apk update
RUN apk add \
    gfortran \
    musl-dev




# Stage to compile Metadise from source in 'metadise_source' directory on host
FROM base AS build

WORKDIR /app

# Copy source code files into container
COPY metadise_source/* /app

# Compile Metadise
RUN gfortran -c *.f
RUN gfortran -o metadise *.o




# Stage to create the production image containing only the Metadise executable
FROM base

WORKDIR /app

RUN apk update
RUN apk add \
    musl-dev

# Copy executable from previous stage
COPY --from=build /app/metadise /app/metadise

ENV PATH=/app:$PATH

# /data is an empty directory to serve as a mount point
WORKDIR /data

# Default command to execute upon execution of container
CMD ["metadise"]
