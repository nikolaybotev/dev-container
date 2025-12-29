FROM homebrew/brew:latest

ENV USER=linuxbrew
ENV HOME=/home/linuxbrew

RUN brew update && brew upgrade

# Bootstrap
RUN sudo apt-get update && \
  sudo apt-get upgrade -y && \
  sudo apt-get install -y zsh vim && \
  sudo apt-get autoremove -y && \
  sudo apt-get clean && \
  sudo rm -rf /var/lib/apt/lists/*

RUN sh -c "$(curl -fsSL https://raw.github.com/nikolaybotev/bootstrap/main/install.sh)"

# Claude Code
RUN curl -fsSL https://claude.ai/install.sh | bash
ENV PATH="${HOME}/.local/bin:${PATH}"

# GitLab CLI
RUN brew install glab

# GitHub CLI
RUN brew install gh

# AWS CLI
RUN brew install awscli

# Google Cloud CLI
#RUN brew install gcloud-cli
RUN curl -fsSL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz \
  | tar -xz -C ${HOME} && \
  ${HOME}/google-cloud-sdk/install.sh --quiet --usage-reporting=false --path-update=true && \
ENV PATH="${HOME}/google-cloud-sdk/bin:${PATH}"
RUN gcloud components install -q alpha beta

# Terraform
RUN brew tap hashicorp/tap && \
  brew install hashicorp/tap/terraform

# Go
RUN brew install go

# vim, htop, mc
RUN brew install vim htop mc
