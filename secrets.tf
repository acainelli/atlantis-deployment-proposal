data "aws_secretsmanager_secret_version" "current" {
  secret_id = var.secret_name
}

locals {
  secret_value       = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)
  atlantis_gh_token  = lookup(local.secret_value, "atlantis_gh_token")
  atlantis_gh_secret = lookup(local.secret_value, "atlantis_gh_secret")
}
