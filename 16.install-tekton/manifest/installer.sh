#!/bin/bash

[[ "$0" != "$BASH_SOURCE" ]] && export install_dir=$(dirname "$BASH_SOURCE") || export install_dir=$(dirname $0)

source "$install_dir/common.sh"

source "$install_dir/installer_pipeline.sh"
source "$install_dir/installer_trigger.sh"
source "$install_dir/installer_operator.sh"

function prepare_online(){
  echo  "========================================================================="
  echo  "=====================  Preparing for CI/CD Modules ======================"
  echo  "========================================================================="

  prepare_tekton_pipeline_online

  prepare_tekton_trigger_online

  prepare_cicd_operator_online
}

function prepare_offline(){
  echo  "========================================================================="
  echo  "=====================  Preparing for CI/CD Modules ======================"
  echo  "========================================================================="

  prepare_tekton_pipeline_offline

  prepare_tekton_trigger_offline

  prepare_cicd_operator_offline
}

function install(){
  echo  "========================================================================="
  echo  "====================  Start Installing CI/CD Modules ===================="
  echo  "========================================================================="

  # Install Tekton Pipelines
  install_tekton_pipeline

  # Install Tekton Trigger
  install_tekton_trigger

  # Install CI/CD Operator
  install_cicd_operator
}

function uninstall(){
  echo  "========================================================================="
  echo  "===================  Start Uninstalling CI/CD Modules ==================="
  echo  "========================================================================="

  # Uninstall CI/CD Operator
  uninstall_cicd_operator

  # Uninstall Tekton Trigger
  uninstall_tekton_trigger

  # Uninstall Tekton Pipelines
  uninstall_tekton_pipeline

  if [[ "$imageRegistry" == "" ]]; then
    kubectl delete -f "https://storage.googleapis.com/tekton-releases/pipeline/previous/$pipelineVersion/release.yaml" "$kubectl_opt"
    kubectl delete -f "https://storage.googleapis.com/tekton-releases/triggers/previous/$triggerVersion/release.yaml" "$kubectl_opt"
    kubectl delete -f "https://raw.githubusercontent.com/tmax-cloud/cicd-operator/$operatorVersion/config/release.yaml" "$kubectl_opt"
  else
    kubectl delete -f "$install_dir/yaml/trigger.yaml" "$kubectl_opt"
    kubectl delete -f "$install_dir/yaml/pipelines.yaml" "$kubectl_opt"
    kubectl delete -f "$install_dir/yaml/operator.yaml" "$kubectl_opt"
  fi
}

function main(){
  case "${1:-}" in
    install)
      install
      ;;
    uninstall)
      uninstall
      ;;
    prepare-online)
      prepare_online
      ;;
    prepare-offline)
      prepare_offline
      ;;
    *)
      echo "Usage: $0 [install|uninstall|prepare-online|prepare-offline]"
      ;;
  esac
}

main "$1"
