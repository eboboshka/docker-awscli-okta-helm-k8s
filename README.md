# aws-cli / okta / helm / kubectl 

The container was designed to work in Jenkins pipeline to deliver helm charts to k8s cluster using OKTA AWS.
Using environment variables, the `envsubst` command creates a `.okta-aws` config file that is required to obtain AWS Security Credentials.

## Docker ARGs:
```
ARG OKTA_BASE_URL="domain.okta.com"
ARG OKTA_USER="user@email.com"
ARG OKTA_PASS="paS$W0rd"
ARG OKTA_FACTOR=""
ARG OKTA_ROLE="arn:aws:iam::..."
ARG OKTA_APP_LINK="https://..."
ARG OKTA_TTL="3600"
```
[ℹ️ Information about the configuration file here](https://github.com/jmhale/okta-awscli#installation)

## This Docker container includes:
 - [aws-cli](https://github.com/aws/aws-cli#aws-cli)
 - [helm](https://github.com/helm/helm#helm)
 - [kubectl](https://github.com/kubernetes/kubectl)
 - [okta-awscli](https://github.com/jmhale/okta-awscli#okta-awscli---retrieve-aws-credentials-from-okta)
 - gettext (envsubst)
 - pip3
 - python3

#### test args:
`docker-compose up --build`
