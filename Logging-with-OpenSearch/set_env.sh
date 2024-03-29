#!/bin/bash

export AWS_REGION=us-west-2
export AWS_PROFILE=ahamadmin
export ACCOUNT_ID=263022081217
export AZS=(us-west-2a us-west-2b us-west-2c us-west-2d)
# export MASTER_ARN=
export ROLE_NAME=eksctl-eks-eksctl-demo-nodegroup-NodeInstanceRole-GWO4TEJEKR0U
#export AWS_BUCKET=
export TEST=ok
#export LBC_VERSION="v2.4.1"
#export LBC_CHART_VERSION="1.4.1"
export CLUSTER_NAME=eks-eksctl-demo
#export KARPENTER_VERSION=v0.16.0
export ES_DOMAIN_NAME=eks-logging
# Elasticsearch version
export ES_VERSION="OpenSearch_1.0"
# OpenSearch Dashboards admin user
export ES_DOMAIN_USER="adminopensearch"
# OpenSearch Dashboards admin password
export ES_DOMAIN_PASSWORD="$(openssl rand -base64 12)_Ek1$"
export ES_ENDPOINT=search-eks-logging-heorfc6pzueheghqboedk3vzca.us-west-2.es.amazonaws.com
export FLUENTBIT_ROLE=arn:aws:iam::263022081217:role/eksctl-eks-eksctl-demo-addon-iamserviceaccou-Role1-1QS2PQKHZ9GWD
