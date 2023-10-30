FROM ubuntu:22.04

ENV HOME=/root

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    sudo \
    python3-pip \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip && pip3 install awscli

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh

RUN mkdir -p /root/.kube/

CMD ["tail", "-f", "/dev/null"]