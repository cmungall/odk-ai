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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install pyenv
RUN curl https://pyenv.run | bash
ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Install Python 3.11 with pyenv and set as global
RUN pyenv install 3.11.9 && \
    pyenv global 3.11.9

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

# Make sure pip is up to date
RUN pip install --upgrade pip

# Install Aurelian at build time as requested
#COPY aurelian-install.sh /tmp/
#RUN chmod +x /tmp/aurelian-install.sh && /tmp/aurelian-install.sh
RUN pip install aurelian

# astroid seems to want an older version of wrapt
RUN pip install "wrapt>=1.17.2"

# #export LOGFIRE_SEND_TO_LOGFIRE=false
ENV LOGFIRE_SEND_TO_LOGFIRE=false

# make sure we have the latest obo-scripts
RUN cd /tools/ && rm -rf obo-scripts && git clone https://github.com/cmungall/obo-scripts

ENV PATH=$PATH:/tools/obo-scripts/

# Set working directory
WORKDIR /work