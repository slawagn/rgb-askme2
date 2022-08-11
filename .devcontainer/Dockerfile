FROM ruby:3.0.2

RUN apt-get update &&   \
    apt-get install -y  \
      sudo

RUN useradd             \
      --create-home     \
      --groups sudo     \
      --shell /bin/bash \
      code
RUN adduser code sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER code

WORKDIR /workspaces/askme

COPY Gemfile Gemfile.lock ./
RUN bundle install
