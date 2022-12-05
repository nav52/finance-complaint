variable "artifact_repository_iam_role_binding" {
  default = "roles/artifactregistry.writer"
  type    = string
}

variable "artifact_repository_iam_members" {
  default = "user:naveenfaster@gmail.com"
  type    = string
}

variable "project_name" {
  default = "finance-complaint-370313"
  type    = string
}

variable "artifact_repository_location" {
  default = "asia-south1"
  type    = string
}

variable "artifact_repository_repository_id" {
  default = "finance-repository"
  type    = string
}

variable "artifact_repository_format" {
  default = "DOCKER"
  type    = string
}