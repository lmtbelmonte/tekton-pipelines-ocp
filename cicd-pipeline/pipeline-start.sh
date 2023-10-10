#!/bin/bash
tkn pipeline start greeter-pipeline-hub \
 --serviceaccount='tekton-deployer-sa' \
 --param GIT_REPO='https://github.com/lmt-cbs/tekton-tutorial-greeter.git' \
 --param GIT_REF='master' \
 --param CONTEXT_DIR='quarkus' \
 --param DESTINATION_IMAGE='quay.io/lmtbelmonte01/tekton-greeter-pipeline:latest' \
 --param IMAGE_DOCKERFILE='quarkus/Dockerfile' \
 --param IMAGE_CONTEXT_DIR='quarkus' \
 --param SCRIPT='kubectl create deploy tekton-greeter --image=quay.io/lmtbelmonte01/tekton-greeter-pipeline:latest' \
 --workspace name=app-source,claimName=app-source-pvc \
 --workspace name=maven-settings,emptyDir="" \
 --use-param-defaults \
 --showlog