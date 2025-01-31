FROM cgr.dev/chainguard/wolfi-base:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="mario@techmunchies.net"

# Copy the setup scripts and package list
COPY ./scripts/devbox.sh /
COPY ./packages/devbox.packages /
COPY ./files /

# Run the setup scripts
RUN /devbox.sh
RUN rm /devbox.sh /devbox.packages

# linuxbrew setup
RUN mv /home/linuxbrew /home/homebrew
