locals {
  alb_name = "${local.cluster_name}-alb"
}

module "alb_controller_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "${local.cluster_name}-${var.aws_lb_chart.name}"

  attach_load_balancer_controller_policy = true #ture로 설정하면 필요한 iam 역할들을 알아서 지정해준다. 

  oidc_providers = {
    one = {
      provider_arn               = local.oidc_provider_arn
      namespace_service_accounts = ["kube-system:${var.aws_lb_chart.name}"]
    }
  }
}

resource "kubernetes_service_account" "alb_controller" {
  metadata {
    name      = var.alb_chart.name
    namespace = var.alb_chart.namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = module.aws_load_balancer_controller_irsa.iam_role_arn
    }
  }
}


### Helm으로 AWS Load Balancer Controller 생성
resource "helm_release" "alb_controller" {
  namespace  = var.alb_chart.namespace
  repository = var.alb_chart.repository
  name    = var.alb_chart.name
  chart   = var.alb_chart.chart
  version = var.alb_chart.version
  
  set {
    name  = "clusterName"
    value = local.cluster_name
  }
  set { # 컨트롤러가 사용할 serviceAccount 생성 X 
    name  = "serviceAccount.create"
    value = "false"
  }
  set { # 만든 serviceAccount 사용
    name  = "serviceAccount.name"
    value = kubernetes_service_account.aws_load_balancer_controller.metavar.0.name
  }
  set {
    name  = "region"
    value = var.region
  }
  set {
    name  = "vpcId"
    value = aws_vpc.vpc.id
  }
  depends_on = [kubernetes_service_account.aws_load_balancer_controller] #ServiceAccount 생성 후 실행 
}