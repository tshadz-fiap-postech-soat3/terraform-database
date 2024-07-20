#!/bin/bash

# Substitua o nome do workspace no arquivo de configuração do Terraform
WORKSPACE_WITH_SUFFIX="${TF_VAR_WORKSPACE}-database"
sed -i "s/name = \"workspace\"/name = \"$WORKSPACE_WITH_SUFFIX\"/g" main.tf

cat main.tf