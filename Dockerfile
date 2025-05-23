FROM obolibrary/odkfull:latest

# Install git and dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    curl \
    liblzma-dev \
    software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install Python 3.11 directly
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3.11-dev python3-pip tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set Python 3.11 as default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 && \
    update-alternatives --set python3 /usr/bin/python3.11 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1 && \
    update-alternatives --set python /usr/bin/python3.11 && \
    ln -sf /usr/bin/python3.11 /usr/local/bin/python

# Install Node.js using NVM
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash \
    && . "$NVM_DIR/nvm.sh" \
    && nvm install 18 \
    && nvm alias default 18 \
    && nvm use default

# Add node and npm to path
ENV PATH=$NVM_DIR/versions/node/v18.19.1/bin:$PATH

# Install claude-code
RUN . "$NVM_DIR/nvm.sh" && npm install -g @anthropic-ai/claude-code 

# Setup pnpm and bun
ENV SHELL=/bin/bash
ENV PNPM_HOME="/root/bin"
ENV BUN_INSTALL="/root/.bun"
ENV PATH="$PNPM_HOME:$BUN_INSTALL/bin:$PATH"

# Install pnpm
RUN curl -fsSL https://get.pnpm.io/install.sh | bash -

# Install bun
RUN curl -fsSL https://bun.sh/install | bash -

# Clone and install cborg-code permanently using token
# Pass GH_TOKEN as a build arg: docker build --build-arg GH_TOKEN=your_token_here ...
ARG GH_TOKEN
RUN mkdir -p /tools/cborg && \
    cd /tools/cborg && \
    git clone https://${GH_TOKEN}@github.com/lbnl-science-it/cborg-code.git . && \
    pnpm install && \
    bun build src/entrypoints/cli.tsx --minify --outfile cli.mjs --target=node && \
    pnpm link --global

# Pre-configure cborg-code with default settings
#RUN mkdir -p /root/.config/cborg-code && \
#    echo '{"model":"anthropic/claude-sonnet","smallModel":"anthropic/claude-haiku"}' > /root/.config/cborg-code/config.json

# Make sure pip is up to date
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11 && \
    python3.11 -m pip install --upgrade pip

# Install Python packages
RUN python3.11 -m pip install aurelian jinja2-cli "wrapt>=1.17.2"

# #export LOGFIRE_SEND_TO_LOGFIRE=false
ENV LOGFIRE_SEND_TO_LOGFIRE=false

# copy the template
COPY template/CLAUDE.md.jinja2 /root/CLAUDE.md.jinja2
# recursively copy the template
COPY template/ /root/template/

# Custom .bashrc additions
COPY bin/git-bashrc-config.sh /tmp/git-bashrc-config.sh
RUN cat /tmp/git-bashrc-config.sh >> ~/.bashrc

# Make sure git and bash-completion are installed
# RUN apt-get update && apt-get install -y  bash-completion

# make sure we have the latest obo-scripts
RUN cd /tools/ && rm -rf obo-scripts && git clone https://github.com/cmungall/obo-scripts

ENV PATH=$PATH:/tools/obo-scripts/

# Copy entrypoint script
COPY bin/entrypoint.sh /usr/local/bin/entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Set working directory
WORKDIR /work

# Default command
CMD ["bash"]