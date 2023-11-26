variable "chart_version" {
  default     = "4.15.3"
  description = "Chart version"
  type        = string
}

variable "chart_name" {
  default     = "atlantis"
  description = "Chart name"
  type        = string
}

variable "namespace" {
  default     = "default"
  description = "Namespace to deploy helm chart"
  type        = string
}

variable "secret_name" {
  default     = "internal/atlantis"
  description = "Name of the secret in AWS Secret Manager"
  type        = string
}

variable "gh_user" {
  default     = "ghuser"
  description = "Name of GitHub user to authenticate"
  type        = string
}

variable "release_name" {
  default     = "atlantis"
  description = "Name of the helm release"
  type        = string
}