#!/bin/sh
#

eval "envsubst << EOF
## https://github.com/jmhale/okta-awscli#installation
[default]
base-url = ${OKTA_BASE_URL}
username = ${OKTA_USER}
password = ${OKTA_PASS}
factor   = ${OKTA_FACTOR}
role     = ${OKTA_ROLE}
app-link = ${OKTA_APP_LINK}
duration = ${OKTA_TTL:-3600}
EOF" > ~/.okta-aws

[ -f ~/.okta-aws ] && $(okta-awscli) || exit 1
