# Tekton CI/CD Installation Guide

**아래 가이드는 HyperCloud 5.x 버전을 위한 가이드임.**

### Module

| SubModule | Version | Guide |
| ------ | --- | ------ |
| Pipeline | v0.26.0 | [Tekton Pipeline Installation Guide](./README-pipelines.md) |
| Trigger | v0.15.0 | [Tekton Trigger Installation Guide](./README-trigger.md) |
| CI/CD Operator | v0.4.2 | [CI/CD Operator Installation Guide](./README-operator.md) |

### 전체 설치
#### 공통
1. cicd.config 설정
    - imageRegistry: 레지스트리 주소 입력 (폐쇄망이 아닐 경우 빈 값으로 설정)
    - 각 모듈 버전: 설치할 모듈 버전 (버전 변경을 추천하지 않음)
#### 폐쇄망일 경우
1. 온라인 환경에서 준비
   ```bash
   ./installer.sh prepare-online
   ```
2. 해당 폴더 (`./yaml`, `./tar` 포함) 폐쇄망 환경으로 복사
3. 실제 폐쇄망 환경에서 준비
   ```bash
   ./installer.sh prepare-offline
   ```
#### 공통
```bash
./installer.sh install
```

### 전체 삭제
```bash
./installer.sh uninstall
```
