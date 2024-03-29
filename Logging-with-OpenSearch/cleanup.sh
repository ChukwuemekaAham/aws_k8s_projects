#!/bin/bash

set -x

cd  ~/environment/

kubectl delete -f ~/environment/logging/fluentbit.yaml

aws opensearch delete-domain \
    --domain-name ${ES_DOMAIN_NAME}

eksctl delete iamserviceaccount \
    --name fluent-bit \
    --namespace logging \
    --cluster eks-eksctl-demo \
    --wait

aws iam delete-policy   \
  --policy-arn "arn:aws:iam::${ACCOUNT_ID}:policy/fluent-bit-policy"

kubectl delete namespace logging

rm -rf ~/environment/logging

unset ES_DOMAIN_NAME
unset ES_VERSION
unset ES_DOMAIN_USER
unset ES_DOMAIN_PASSWORD
unset FLUENTBIT_ROLE
unset ES_ENDPOINT