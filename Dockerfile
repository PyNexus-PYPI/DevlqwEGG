# Stage 1: Build stage for Ubuntu 20.04
FROM ubuntu:20.04 as ubuntu20
RUN apt update && apt install -y sudo bash curl nano dialog

# Stage 2: Build stage for Ubuntu 22.04
FROM ubuntu:22.04 as ubuntu22
RUN apt update && apt install -y sudo bash curl nano dialog

# Final Stage: Use selection from install.sh script
# Default to ubuntu:20.04, but the actual image is decided dynamically by install.sh
FROM ubuntu:20.04

# Copy the installation script
COPY ./install.sh /install.sh
RUN chmod +x /install.sh

# Run the install script on container startup
CMD ["/bin/bash", "/install.sh"]
