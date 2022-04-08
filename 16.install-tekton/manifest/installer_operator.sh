#!/bin/bash

function prepare_cicd_operator_online(){
  curl -s "https://raw.githubusercontent.com/tmax-cloud/cicd-operator/$operatorVersion/config/release.yaml" -o "$install_dir/yaml/operator.yaml"
  curl -s "https://raw.githubusercontent.com/tmax-cloud/cicd-operator/$operatorVersion/config/crd-key-mapping/cicd.tmax.io_approvals.yaml" -o "$install_dir/yaml/cicd.tmax.io_approvals.yaml"
  curl -s "https://raw.githubusercontent.com/tmax-cloud/cicd-operator/$operatorVersion/config/crd-key-mapping/cicd.tmax.io_integrationconfigs.yaml" -o "$install_dir/yaml/cicd.tmax.io_integrationconfigs.yaml"
  curl -s "https://raw.githubusercontent.com/tmax-cloud/cicd-operator/$operatorVersion/config/crd-key-mapping/cicd.tmax.io_integrationjobs.yaml" -o "$install_dir/yaml/cicd.tmax.io_integrationjobs.yaml"

  sudo docker pull "tmaxcloudck/cicd-operator:$operatorVersion"
  sudo docker pull "tmaxcloudck/cicd-blocker:$operatorVersion"
  sudo docker pull docker.io/alpine/git:1.0.30

  sudo docker tag "tmaxcloudck/cicd-operator:$operatorVersion" "cicd-operator:$operatorVersion"
  sudo docker tag "tmaxcloudck/cicd-blocker:$operatorVersion" "cicd-blocker:$operatorVersion"
  sudo docker tag docker.io/alpine/git:1.0.30 alpine/git:1.0.30

  sudo docker save "cicd-operator:$operatorVersion" > "$install_dir/tar/cicd-operator-$operatorVersion.tar"
  sudo docker save "cicd-blocker:$operatorVersion" > "$install_dir/tar/cicd-blocker-$operatorVersion.tar"
  sudo docker save alpine/git:1.0.30 > "$install_dir/tar/alpine-git-1.0.30.tar"
}

function prepare_cicd_operator_offline(){
  sudo docker load < "$install_dir/tar/cicd-operator-$operatorVersion.tar"
  sudo docker load < "$install_dir/tar/cicd-blocker-$operatorVersion.tar"
  sudo docker load < "$install_dir/tar/alpine-git-1.0.30.tar"

  sudo docker tag "cicd-operator:$operatorVersion" "$imageRegistry/cicd-operator:$operatorVersion"
  sudo docker tag "cicd-blocker:$operatorVersion" "$imageRegistry/cicd-blocker:$operatorVersion"
  sudo docker tag alpine/git:1.0.30 "$imageRegistry/alpine/git:1.0.30"

  sudo docker push "$imageRegistry/cicd-operator:$operatorVersion"
  sudo docker push "$imageRegistry/cicd-blocker:$operatorVersion"
  sudo docker push "$imageRegistry/alpine/git:1.0.30"
}

function install_cicd_operator(){
  echo  "========================================================================="
  echo  "===================  Start Installing CI/CD Operator ===================="
  echo  "========================================================================="
  # Set tekton config
  kubectl -n tekton-pipelines patch configmap feature-flags --type merge -p '{"data": {"enable-custom-tasks": "true", "disable-affinity-assistant": "true"}}' "$kubectl_opt"

  if [[ "$imageRegistry" == "" ]]; then
    kubectl apply -f "https://raw.githubusercontent.com/tmax-cloud/cicd-operator/$operatorVersion/config/release.yaml" "$kubectl_opt"

    # Replace with i18n CRDs
    kubectl replace -f "https://raw.githubusercontent.com/tmax-cloud/cicd-operator/$operatorVersion/config/crd-key-mapping/cicd.tmax.io_approvals.yaml" "$kubectl_opt"
    kubectl replace -f "https://raw.githubusercontent.com/tmax-cloud/cicd-operator/$operatorVersion/config/crd-key-mapping/cicd.tmax.io_integrationconfigs.yaml" "$kubectl_opt"
    kubectl replace -f "https://raw.githubusercontent.com/tmax-cloud/cicd-operator/$operatorVersion/config/crd-key-mapping/cicd.tmax.io_integrationjobs.yaml" "$kubectl_opt"
  else
    sed -i -E "s/tmaxcloudck\/([^\n\"]*)/$imageRegistry\/\1/g" "$install_dir/yaml/operator.yaml"
    sed -i -E "s/tmaxcloudck\/([^\n\"]*)/$imageRegistry\/\1/g" "$install_dir/yaml/blocker_deploy.yaml"
    sed -i -E "s/tmaxcloudck\/([^\n\"]*)/$imageRegistry\/\1/g" "$install_dir/yaml/controller_deploy.yaml"

    kubectl apply -f "$install_dir/yaml/operator.yaml" "$kubectl_opt"

    # Replace with i18n CRDs
    kubectl replace -f "$install_dir/yaml/cicd.tmax.io_approvals.yaml" "$kubectl_opt"
    kubectl replace -f "$install_dir/yaml/cicd.tmax.io_integrationconfigs.yaml" "$kubectl_opt"
    kubectl replace -f "$install_dir/yaml/cicd.tmax.io_integrationjobs.yaml" "$kubectl_opt"

    kubectl -n cicd-system patch cm cicd-config --type merge -p "{\"data\": {\"gitImage\": \"$REGISTRY/alpine/git:1.0.30\"}}"
  fi

  # For Service account
  kubectl apply -f "$install_dir/yaml/service_account.yaml" "$kubectl_opt"
  kubectl apply -f "$install_dir/yaml/blocker_deploy.yaml" "$kubectl_opt"
  kubectl apply -f "$install_dir/yaml/controller_deploy.yaml" "$kubectl_opt"
  kubectl apply -f "$install_dir/yaml/role_binding.yaml" "$kubectl_opt"

  kubectl -n cicd-system patch configmap cicd-config --type merge -p '{"data": {"ingressClass": "nginx-shd"}}' "$kubectl_opt"
  echo  "========================================================================="
  echo  "================  Successfully Installed CI/CD Operator ================="
  echo  "========================================================================="
}

function uninstall_cicd_operator(){
  echo  "========================================================================="
  echo  "==================  Start Uninstalling CI/CD Operator ==================="
  echo  "========================================================================="
  get_resources crd | grep '^[^\.]*\.cicd\.tmax\.io' | awk '{print $1}' | while read line; do
    echo "Deleting $line"
    delete_resources "$line"
  done

  kubectl -n cicd-system delete deployment cicd-operator "$kubectl_opt"
  echo  "========================================================================="
  echo  "===============  Successfully Uninstalled CI/CD Operator ================"
  echo  "========================================================================="
}
