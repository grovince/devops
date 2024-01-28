# AWS 3-Tier 환경 및 CI/CD 파이프라인 구축
</br>

### 프로젝트 소개
#### 프로젝트명
* AWS 3-Tier 환경 및 CI/CD 파이프라인 구축
</br>

#### 프로젝트 소개
* Web-WAS-DB로 구성된 3-Tier 환경 구축
* AWS EKS를 중점으로 클러스터 환경 구축
* CI/CD 파이프라인으로 구성된 자동화 배포
</br>

#### 주요 사용 기술
- AWS EKS (AWS Elastic Kubernetes Service)
- AWS Load Balancer
- AWS RDS
- GitHub Action
- ArgoCD
</br>

---

</br>

### 프로젝트 내용
#### 주요 핵심 기술
1. Kubernetes Service
    - SVC, Deployment, Statefulset, ConfigMap, Secret, PV/PVC
2. AWS Cloud Service
    - Route 53 - 도메인 관리
    - Ingress Controller - 부하분산
    - RDS - 데이터 관리
    - ECR (Elastic Container Registry) - 이미지 저장소
    - EKS (Elastic Kubernetes Service) - 컨테이너 오케스트레이션
    - ACM (AWS Certificate Manager) - HTTPS 통신 인증서 발급 (보안)
3. CICD
    - Code repository로 Github 사용
    - Gtihub Action
    - ArgoCD
