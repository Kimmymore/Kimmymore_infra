variable "project_name" {
  default = "test_project"
}

variable "project_description" {
  default = "Fill in Description"
}

variable "gitignore_value" {
  default = <<EOT
**/.terraform/*
*.tfstate
*.tfstate.*
crash.log
override.tf
override.tf.json
EOT
}

variable "project_owner" {
  default = "kim.willemse@cloudnation.nl"
}
