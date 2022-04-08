#!/bin/bash

function prepare_tekton_pipeline_online(){
  curl -s "https://storage.googleapis.com/tekton-releases/pipeline/previous/$pipelineVersion/release.yaml" -o yaml/pipelines.yaml

  sudo docker pull "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/controller:$pipelineVersion"
  sudo docker pull "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/webhook:$pipelineVersion"
  sudo docker pull "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/kubeconfigwriter:$pipelineVersion"
  sudo docker pull "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/git-init:$pipelineVersion"
  sudo docker pull "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/entrypoint:$pipelineVersion"
  sudo docker pull "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/nop:$pipelineVersion"
  sudo docker pull "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/imagedigestexporter:$pipelineVersion"
  sudo docker pull "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/pullrequest-init:$pipelineVersion"
  sudo docker pull "gcr.io/google.com/cloudsdktool/cloud-sdk@sha256:27b2c22bf259d9bc1a291e99c63791ba0c27a04d2db0a43241ba0f1f20f4067f"
  sudo docker pull "gcr.io/distroless/base@sha256:92720b2305d7315b5426aec19f8651e9e04222991f877cae71f40b3141d2f07e"

  sudo docker tag "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/controller:$pipelineVersion" "pipelines-controller:$pipelineVersion"
  sudo docker tag "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/webhook:$pipelineVersion" "pipelines-webhook:$pipelineVersion"
  sudo docker tag "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/kubeconfigwriter:$pipelineVersion" "pipelines-kubeconfigwriter:$pipelineVersion"
  sudo docker tag "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/git-init:$pipelineVersion" "pipelines-git-init:$pipelineVersion"
  sudo docker tag "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/entrypoint:$pipelineVersion" "pipelines-entrypoint:$pipelineVersion"
  sudo docker tag "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/nop:$pipelineVersion" "pipelines-nop:$pipelineVersion"
  sudo docker tag "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/imagedigestexporter:$pipelineVersion" "pipelines-imagedigestexporter:$pipelineVersion"
  sudo docker tag "gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/pullrequest-init:$pipelineVersion" "pipelines-pullrequest-init:$pipelineVersion"
  sudo docker tag "gcr.io/google.com/cloudsdktool/cloud-sdk@sha256:27b2c22bf259d9bc1a291e99c63791ba0c27a04d2db0a43241ba0f1f20f4067f" "pipelines-cloud-sdk:$pipelineVersion"
  sudo docker tag "gcr.io/distroless/base@sha256:92720b2305d7315b5426aec19f8651e9e04222991f877cae71f40b3141d2f07e" "pipelines-base:$pipelineVersion"

  sudo docker save "pipelines-controller:$pipelineVersion" > "$install_dir/tar/pipelines-controller-$pipelineVersion.tar"
  sudo docker save "pipelines-webhook:$pipelineVersion" > "$install_dir/tar/pipelines-webhook-$pipelineVersion.tar"
  sudo docker save "pipelines-kubeconfigwriter:$pipelineVersion" > "$install_dir/tar/pipelines-kubeconfigwriter-$pipelineVersion.tar"
  sudo docker save "pipelines-git-init:$pipelineVersion" > "$install_dir/tar/pipelines-git-init-$pipelineVersion.tar"
  sudo docker save "pipelines-entrypoint:$pipelineVersion" > "$install_dir/tar/pipelines-entrypoint-$pipelineVersion.tar"
  sudo docker save "pipelines-nop:$pipelineVersion" > "$install_dir/tar/pipelines-nop-$pipelineVersion.tar"
  sudo docker save "pipelines-imagedigestexporter:$pipelineVersion" > "$install_dir/tar/pipelines-imagedigestexporter-$pipelineVersion.tar"
  sudo docker save "pipelines-pullrequest-init:$pipelineVersion" > "$install_dir/tar/pipelines-pullrequest-init-$pipelineVersion.tar"
  sudo docker save "pipelines-cloud-sdk:$pipelineVersion" > "$install_dir/tar/pipelines-cloud-sdk-$pipelineVersion.tar"
  sudo docker save "pipelines-base:$pipelineVersion" > "$install_dir/tar/pipelines-base-$pipelineVersion.tar"
}

function prepare_tekton_pipeline_offline(){
  sudo docker load < "$install_dir/tar/pipelines-controller-$pipelineVersion.tar"
  sudo docker load < "$install_dir/tar/pipelines-webhook-$pipelineVersion.tar"
  sudo docker load < "$install_dir/tar/pipelines-kubeconfigwriter-$pipelineVersion.tar"
  sudo docker load < "$install_dir/tar/pipelines-git-init-$pipelineVersion.tar"
  sudo docker load < "$install_dir/tar/pipelines-entrypoint-$pipelineVersion.tar"
  sudo docker load < "$install_dir/tar/pipelines-nop-$pipelineVersion.tar"
  sudo docker load < "$install_dir/tar/pipelines-imagedigestexporter-$pipelineVersion.tar"
  sudo docker load < "$install_dir/tar/pipelines-pullrequest-init-$pipelineVersion.tar"
  sudo docker load < "$install_dir/tar/pipelines-cloud-sdk-$pipelineVersion.tar"
  sudo docker load < "$install_dir/tar/pipelines-base-$pipelineVersion.tar"

  sudo docker tag "pipelines-controller:$pipelineVersion" "$imageRegistry/pipelines-controller:$pipelineVersion"
  sudo docker tag "pipelines-webhook:$pipelineVersion" "$imageRegistry/pipelines-webhook:$pipelineVersion"
  sudo docker tag "pipelines-kubeconfigwriter:$pipelineVersion" "$imageRegistry/pipelines-kubeconfigwriter:$pipelineVersion"
  sudo docker tag "pipelines-git-init:$pipelineVersion" "$imageRegistry/pipelines-git-init:$pipelineVersion"
  sudo docker tag "pipelines-entrypoint:$pipelineVersion" "$imageRegistry/pipelines-entrypoint:$pipelineVersion"
  sudo docker tag "pipelines-nop:$pipelineVersion" "$imageRegistry/pipelines-nop:$pipelineVersion"
  sudo docker tag "pipelines-imagedigestexporter:$pipelineVersion" "$imageRegistry/pipelines-imagedigestexporter:$pipelineVersion"
  sudo docker tag "pipelines-pullrequest-init:$pipelineVersion" "$imageRegistry/pipelines-pullrequest-init:$pipelineVersion"
  sudo docker tag "pipelines-cloud-sdk:$pipelineVersion" "$imageRegistry/pipelines-cloud-sdk:$pipelineVersion"
  sudo docker tag "pipelines-base:$pipelineVersion" "$imageRegistry/pipelines-base:$pipelineVersion"

  sudo docker push "$imageRegistry/pipelines-controller:$pipelineVersion"
  sudo docker push "$imageRegistry/pipelines-webhook:$pipelineVersion"
  sudo docker push "$imageRegistry/pipelines-kubeconfigwriter:$pipelineVersion"
  sudo docker push "$imageRegistry/pipelines-git-init:$pipelineVersion"
  sudo docker push "$imageRegistry/pipelines-entrypoint:$pipelineVersion"
  sudo docker push "$imageRegistry/pipelines-nop:$pipelineVersion"
  sudo docker push "$imageRegistry/pipelines-imagedigestexporter:$pipelineVersion"
  sudo docker push "$imageRegistry/pipelines-pullrequest-init:$pipelineVersion"
  sudo docker push "$imageRegistry/pipelines-cloud-sdk:$pipelineVersion"
  sudo docker push "$imageRegistry/pipelines-base:$pipelineVersion"
}

function install_tekton_pipeline(){
  echo  "========================================================================="
  echo  "===================  Start Installing Tekton Pipeline ==================="
  echo  "========================================================================="

  if [[ "$imageRegistry" == "" ]]; then
    kubectl apply -f "https://storage.googleapis.com/tekton-releases/pipeline/previous/$pipelineVersion/release.yaml" "$kubectl_opt"
  else
    sed -i -E "s/gcr.io\/[^\n\"]*\/([^@:]*)(:[^@]*)?@[^\n\"]*/$imageRegistry\/pipelines-\1:$pipelineVersion/g" "$install_dir/yaml/pipelines.yaml"

    kubectl apply -f "$install_dir/yaml/pipelines.yaml" "$kubectl_opt"
  fi
  echo  "========================================================================="
  echo  "================  Successfully Installed Tekton Pipeline ================"
  echo  "========================================================================="
}

function uninstall_tekton_pipeline(){
  echo  "========================================================================="
  echo  "==================  Start Uninstalling Tekton Pipeline =================="
  echo  "========================================================================="
  get_resources crd | grep '^[^\.]*\.tekton\.dev' | awk '{print $1}' | while read line; do
    echo "Deleting $line"
    delete_resources "$line"
  done

  kubectl -n tekton-pipelines delete deployment tekton-pipelines-controller "$kubectl_opt"
  kubectl -n tekton-pipelines delete deployment tekton-pipelines-webhook "$kubectl_opt"
  echo  "========================================================================="
  echo  "===============  Successfully Uninstalled Tekton Pipeline ==============="
  echo  "========================================================================="
}
