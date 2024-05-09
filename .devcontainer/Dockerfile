FROM mcr.microsoft.com/devcontainers/javascript-node:1-20-bullseye

# [Optional] Uncomment to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment if you want to install an additional version of node using nvm
# ARG EXTRA_NODE_VERSION=10
# RUN su node -c "source /usr/local/share/nvm/nvm.sh && nvm install ${EXTRA_NODE_VERSION}"

# [Optional] Uncomment to install more global node modules
# RUN su node -c "npm install -g <your-package-list-here>"

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

# Switch back to user root if you need to perform operations as root below this line
# USER root

# Add node user to sudoers with no password prompt (if needed)
# RUN adduser node sudo && \
#    echo 'node ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers