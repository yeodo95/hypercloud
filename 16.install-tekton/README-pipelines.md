# Tekton Pipelines 설치 가이드

## 구성 요소 및 버전
* controller ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/controller:v0.26.0](https://console.cloud.google.com/gcr/images/tekton-releases/global/github.com/tektoncd/pipeline/cmd/controller@sha256:db1d486fac10b1eca6d7b8daf4764a15f8c70e67961457c73d8c04964a3e4929/details?tab=info))
* webhook ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/webhook:v0.26.0](https://console.cloud.google.com/gcr/images/tekton-releases/global/github.com/tektoncd/pipeline/cmd/webhook@sha256:79cf8b670ab008d605362641443648d9ac0ff247f1f943bb4d5209716a9b49fa/details?tab=info))
* kubeconfigwriter ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/kubeconfigwriter:v0.26.0](https://console.cloud.google.com/gcr/images/tekton-releases/global/github.com/tektoncd/pipeline/cmd/kubeconfigwriter@sha256:a4471a7ef4bdec4b4f4d08c20df0b762140142701c1197e1f57eca10b741db3a/details?tab=info))
* git-init ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/git-init:v0.26.0](https://console.cloud.google.com/gcr/images/tekton-releases/global/github.com/tektoncd/pipeline/cmd/git-init@sha256:8a5ed01f5a0684a90a2f42d247a10a2274f974759562329b200abaed4a804508/details?tab=info))
* entrypoint ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/entrypoint:v0.26.0](https://console.cloud.google.com/gcr/images/tekton-releases/global/github.com/tektoncd/pipeline/cmd/entrypoint@sha256:6a99fea33bb3dd1c20a16837cd88af0a120ba699c3f3e18ea9338fba78387556/details?tab=info))
* nop ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/nop:v0.26.0](https://console.cloud.google.com/gcr/images/tekton-releases/global/github.com/tektoncd/pipeline/cmd/nop@sha256:8c6a241f71b54c39c001c94128013e6abd8693c64aa1231f1d19b2e50f57d3af/details?tab=info))
* imagedigestexporter ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/imagedigestexporter:v0.26.0](https://console.cloud.google.com/gcr/images/tekton-releases/global/github.com/tektoncd/pipeline/cmd/imagedigestexporter@sha256:92a090944f89a679bb3632ae1b8c8afa30ef5a9eb7d4a3bdbca6f13967db8d3d/details?tab=info))
* pullrequest-init ([gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/pullrequest-init:v0.26.0](https://console.cloud.google.com/gcr/images/tekton-releases/global/github.com/tektoncd/pipeline/cmd/pullrequest-init@sha256:1ab4207300c431f2098e6f6cbdb3fd6c8058900bbf06b398f159668419903b68/details?tab=info))
* cloud-sdk ([gcr.io/google.com/cloudsdktool/cloud-sdk](https://console.cloud.google.com/gcr/images/google.com:cloudsdktool/GLOBAL/cloud-sdk@sha256:27b2c22bf259d9bc1a291e99c63791ba0c27a04d2db0a43241ba0f1f20f4067f/details?tab=info))
* base ([gcr.io/distroless/base](https://console.cloud.google.com/gcr/images/distroless/global/base@sha256:4bd9d1ead94de3799035f7d92ba38e4061a1ab2de13e5755c7bf082eccf6afe7/details?tab=info))

## 폐쇄망 설치 가이드
설치를 진행하기 전 아래의 과정을 통해 필요한 이미지 및 yaml 파일을 준비한다.
1. 폐쇄망에서 설치하는 경우 사용하는 image repository에 Tekton Pipelines 설치 시 필요한 이미지를 push한다.
    * 작업 디렉토리 생성 및 환경 설정
   ```bash
   git clone https://github.com/tmax-cloud/install-tekton.git -b 5.0 --single-branch
   cd install-tekton
   
   source common.sh
   source installer_pipeline.sh
    
   prepare_tekton_pipeline_online
   ```

2. 폐쇄망 환경으로 전송
   ```bash
   # 생성된 파일 모두 SCP 또는 물리 매체를 통해 폐쇄망 환경으로 복사
   cd ..
   scp -r install-tekton <REMOTE_SERVER>:<PATH>
   ``` 

3. cicd.config 설정
   ```config
   imageRegistry=172.22.11.2:30500 # 레지스트리 주소 (폐쇄망 아닐 경우 빈 값으로 설정)
   ```

4. 위의 과정에서 생성한 tar 파일들을 폐쇄망 환경으로 이동시킨 뒤 사용하려는 registry에 이미지를 push한다.
   ```bash
   source common.sh
   source installer_pipeline.sh
   
   prepare_tekton_pipeline_offline
   ```

## 설치 가이드
1. [Pipelines 설치](#step-1-pipelines-설치)

## Step 1. Pipelines 설치
* 목적 : `Tekton Pipelines에 필요한 구성 요소 설치`
* 생성 순서 : 아래 command로 설치 yaml 적용
   ```bash
   source common.sh
   source installer_pipeline.sh
  
   install_tekton_pipeline 
   ```


## 삭제 가이드
1. [Pipelines 삭제](#step-1-pipelines-삭제)

## Step 1. Pipelines 삭제
* 목적 : `Tekton Pipelines 구성 요소 삭제`
* 생성 순서 : 아래 command로 설치 yaml 삭제
   ```bash
   source common.sh
   source installer_pipeline.sh
  
   uninstall_tekton_pipeline 
   ```
