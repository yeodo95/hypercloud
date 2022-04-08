# Tekton Trigger 설치 가이드

## 구성 요소 및 버전
* controller ([gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/controller:v0.15.0](https://console.cloud.google.com/gcr/images/tekton-releases/global/github.com/tektoncd/triggers/cmd/controller@sha256:f844b0fdf4f47898f11b4050a65aa5a621cfa92cc1090fc514b54b058a90c491/details?tab=info))
* webhook ([gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/webhook:v0.15.0](https://console.cloud.google.com/gcr/images/tekton-releases/global/github.com/tektoncd/triggers/cmd/webhook@sha256:f81a92eaa2d8b359db597239ac70bfcfef4d50da2294ea0de2322226e72a1eae/details?tab=info))
* interceptors ([gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/interceptors:v0.15.0](https://console.cloud.google.com/gcr/images/tekton-releases/global/github.com/tektoncd/triggers/cmd/interceptors@sha256:1d12af37ddc4b0f63f7897b4cb3732dd0ae4dc2bf725be5ba0c821c1405c947c/details?tab=info))
* eventlistenersink ([gcr.io/tekton-releases/github.com/tektoncd/triggers/cmd/eventlistenersink:v0.15.0](https://console.cloud.google.com/gcr/images/tekton-releases/global/github.com/tektoncd/triggers/cmd/eventlistenersink@sha256:7289cbad13d15cdc2dd9cf96f03018b1dce7e0e348cfe7465bb116b226e8c386/details?tab=info))


## Prerequisites
1. [Tekton Pipelines](./README-pipelines.md)

## 폐쇄망 설치 가이드
설치를 진행하기 전 아래의 과정을 통해 필요한 이미지 및 yaml 파일을 준비한다.
1. 폐쇄망에서 설치하는 경우 사용하는 image repository에 Tekton Trigger 설치 시 필요한 이미지를 push한다.
    * 작업 디렉토리 생성 및 환경 설정
   ```bash
   git clone https://github.com/tmax-cloud/install-tekton.git -b 5.0 --single-branch
   cd install-tekton
   
   source common.sh
   source installer_trigger.sh
    
   prepare_tekton_trigger_online
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
   source installer_trigger.sh
   
   prepare_tekton_trigger_offline
   ```

## Install Steps
1. [Trigger 설치](#step-1-trigger-설치)

## Step 1. Trigger 설치
* 목적 : `Tekton Trigger에 필요한 구성 요소 설치`
* 생성 순서 : 아래 command로 설치 yaml 적용
   ```bash
   source common.sh
   source installer_trigger.sh
  
   install_tekton_trigger
   ```


## 삭제 가이드
1. [Trigger 삭제](#step-1-trigger-삭제)

## Step 1. Trigger 삭제
* 목적 : `Tekton Trigger 구성 요소 삭제`
* 생성 순서 : 아래 command로 설치 yaml 삭제
   ```bash
   source common.sh
   source installer_trigger.sh
  
   uninstall_tekton_trigger 
   ```
