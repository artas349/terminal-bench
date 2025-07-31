FROM debian:bookworm

# Install dependencies
RUN apt-get update && apt-get install -y \
    bash \
    jq \
    curl \
    coreutils \
    grep \
    gawk \
    tmux \
    asciinema \
    python3 \
    python3-pip \
 && python3 -m pip install --break-system-packages unittest-xml-reporting \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /home/project

# Copy all task files
COPY . /home/project

CMD ["bash"]
