module "atlantis" {
  source  = "terraform-module/release/helm"
  version = "2.6.0"

  namespace  = var.namespace
  repository = "https://runatlantis.github.io/helm-charts"

  app = {
    name          = var.release_name
    version       = var.chart_version
    chart         = var.chart_name
    force_update  = true
    wait          = false
    recreate_pods = false
    deploy        = 1
  }
  values = [templatefile("templates/atlantis-values.yml", {
    # Any custom values here
  })]

  set = []

  set_sensitive = [
    {
      path  = "github.user"
      value = var.gh_user
    },
    {
      path  = "github.token"
      value = local.atlantis_gh_token
    },
    {
      path  = "github.secret"
      value = local.atlantis_gh_secret
    }
  ]
}

resource "kubernetes_manifest" "whitelisted-github-ips" {
  manifest = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "Middleware"
    metadata = {
      name      = "whitelisted-github-ips"
      namespace = var.namespace
    }
    spec = {
      ipWhiteList = {
        sourceRange = [
          "192.30.252.0/22",
          "185.199.108.0/22",
          "140.82.112.0/20",
          "143.55.64.0/20",
          "2a0a:a440::/29",
          "2606:50c0::/32"
        ]
      }
    }
  }
}
