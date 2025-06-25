# Kube Labs

## ความต้องการพื้นฐาน (Prerequisites)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [helm](https://helm.sh/docs/intro/install/)
- [kind](https://kind.sigs.k8s.io/)

## วิธีติดตั้งเครื่องมือพื้นฐาน

### ติดตั้ง kubectl
```sh
brew install kubectl
```

### ติดตั้ง helm
```sh
brew install helm
```

### ติดตั้ง kind
```sh
brew install kind
```

## วิธีใช้งาน

### 1. สร้าง Kubernetes Cluster
```sh
make cluster
```

### 2. ติดตั้ง Ingress Controller
```sh
make ingress
```

### 3. ติดตั้ง Jenkins
```sh
make deploy-jenkins
make jenkins-ingress
```

### 4. ติดตั้ง Argo CD
```sh
make argo-cd
make argo-cd-ingress
```

### 5. ติดตั้ง httpbin
```sh
make httpbin-deploy
```

## การลบ (Cleanup)
- Jenkins: `make jenkins-delete`
- Argo CD: `make argo-cd-delete`
- httpbin: `make httpbin-delete`
- ลบ cluster: `make destroy-cluster`

## การเข้าใช้งาน
- Jenkins: http://jenkins.127.0.0.1.nip.io
- Argo CD: http://argo.127.0.0.1.nip.io
- httpbin: http://httpbin.127.0.0.1.nip.io

## หมายเหตุ
- หากต้องการดูรหัสผ่านเริ่มต้นของ Argo CD:
  ```sh
  make argo-init-password
  ```
- หากต้องการ port-forward:
  - Jenkins: `make port-forward-jenkins`
  - Argo CD: `make port-forward-argo-cd` 