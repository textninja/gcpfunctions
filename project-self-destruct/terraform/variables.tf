variable "folder_id" {
  type = string
  description = "Parent folder for the project"
}

variable "project" {
  type = string
  description = "Project ID in which to deploy self-destruct capability"
}

variable "billing_account" {
  type = string
  description = "The project's billing account ID"
}

variable "region" {
  type = string
  default = "us-west1"
  description = "The region in which to deploy the self-destruct function"
}
