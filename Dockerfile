FROM node:lts-bullseye-slim

WORKDIR /app
COPY . .

RUN chown -R node:node /app

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends sudo python3 python3-dev python3-pip \
    build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils \
    tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev git ca-certificates

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

# Install app dependencies
USER root
RUN npm install

USER node
RUN pip3 install --upgrade pip && \ 
    pip3 install -r requirements.txt

ENTRYPOINT ["./entrypoint.sh"]

