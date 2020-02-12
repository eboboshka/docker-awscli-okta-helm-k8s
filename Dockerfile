FROM python:alpine
LABEL maintainer="Artem Trutko <trutko.artem@gmail.com>"
LABEL repository="https://github.com/eboboshka/docker-awscli-okta-helm-k8s"

ARG AWSCLI_VERSION="1.17.15"
ARG HELM_VERSION="2.15.1"
ARG K8S_VERSION="1.14.10"
ARG OKTA_AWS_VERSION="0.4.0"

WORKDIR /root/

COPY ./okta-aws.template ./
## https://github.com/helm/helm/tags
ADD https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz /tmp/
## https://github.com/kubernetes/kubernetes/releases
## https://storage.googleapis.com/kubernetes-release/release/stable.txt
ADD https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kubectl /usr/local/bin

RUN apk add -U --no-cache ca-certificates gettext git bash && \
  pip3 install --no-cache-dir --upgrade pip && \
  pip3 --no-cache-dir install awscli==${AWSCLI_VERSION} okta-awscli==${OKTA_AWS_VERSION} && \
  tar -xf /tmp/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
  mv linux-amd64/helm /usr/local/bin && \
  chmod +x /usr/local/bin/helm /usr/local/bin/kubectl && \
  rm -rf /tmp/* /var/cache/apk/*

## OKTA-AWSCLI
## https://github.com/jmhale/okta-awscli#installation
ARG OKTA_BASE_URL="domain.okta.com"
ARG OKTA_USER="user@email.com"
ARG OKTA_PASS="paS$W0rd"
ARG OKTA_FACTOR=""
ARG OKTA_ROLE="arn:aws:iam::..."
ARG OKTA_APP_LINK="https://..."
ARG OKTA_TTL="3600"

RUN envsubst < ./okta-aws.template > ./.okta-aws

CMD ["/bin/sh"]
