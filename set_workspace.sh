#!/bin/bash

# Substitua o nome do workspace no arquivo de configuração do Terraform
sed -i "s/name = \"workspace\"/name = \"$TF_VAR_WORKSPACE\"/g" main.tf

cat main.tf