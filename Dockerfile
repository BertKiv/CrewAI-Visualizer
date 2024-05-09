FROM mcr.microsoft.com/devcontainers/javascript-node:1-20-bullseye

WORKDIR /app
COPY . .

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends sudo python3 python3-dev python3-pip \
    build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils \
    tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev git ca-certificates

# Install pyenv as node user, not root
USER node

ENV PYENV_ROOT /home/node/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Install Python 3.12
ENV PYTHON_VERSION 3.12.0
RUN curl https://pyenv.run | bash && \
    eval "$(pyenv init --path)" && \
    pyenv install $PYTHON_VERSION && \
    pyenv global $PYTHON_VERSION && \
    pyenv rehash

RUN /bin/bash -c "setup_linux_mac.sh"
ENTRYPOINT ["npm", "run", "start"]

