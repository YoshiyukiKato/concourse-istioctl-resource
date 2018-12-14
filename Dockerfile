FROM alpine:3.7

WORKDIR /

RUN apk add --update --upgrade --no-cache jq bash curl tar
ARG KUBERNETES_VERSION=1.11.3
RUN curl -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl; \
    chmod +x /usr/local/bin/kubectl

ARG ISTIO_VERSION=1.0.4
RUN curl -L -o istio.tgz https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/istio-${ISTIO_VERSION}-linux.tar.gz
RUN tar -xf istio.tgz
ENV PATH=/istio-${ISTIO_VERSION}/bin:$PATH

ADD assets /opt/resource
RUN chmod +x /opt/resource/*

RUN apk del curl tar
RUN rm istio.tgz

ENTRYPOINT [ "/bin/bash"]
