# Stage containing Metadise dependencies
FROM alpine:3.21.3 AS base

# Define non-root user variables - specified at build time.
# These define the user owning the app and the default user in the
# container when it is run
ARG UID=1000
ARG GID=1000
ARG USERNAME=appuser

# Create the non-root user
RUN addgroup -g $GID $USERNAME && \
    adduser -D -u $UID -G $USERNAME -s /bin/bash $USERNAME

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

# Copy executable from previous stage
COPY --from=build /app/metadise /app/metadise
# Give all users execute permission for the executable
RUN chmod a+x /app/metadise

ENV PATH=/app:$PATH

# /data is an empty directory to serve as a mount point
WORKDIR /data

# Ensure non-root user owns /app
RUN chown -R $USERNAME:$USERNAME /app
# But allow any user in the container to do access the /app directory.
RUN chmod a+rwx /app

# Switch to non-root user
USER $USERNAME

# Default command to execute upon execution of container
CMD ["metadise"]
