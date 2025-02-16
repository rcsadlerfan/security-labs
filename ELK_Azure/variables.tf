variable "slug" {
  type = string
  default = "lab_elk"
  description = "Slug to be attached to all resources created. Use this to track all lab-related infrastructure"
}

variable "location" {
  type = string
  default = "East US"
  description = "The Azure location to use for the lab infrastructure"
}

variable "pass" {
  type = string
  sensitive = true
  ephemeral = true
  description = "Password to use when provisioning the virtual machines. This value WILL NOT be stored, so you MUST enter it every time you run the Terraform playbooks"
}

variable "subscription_id" {
  type = string
  description = "Azure subscription where you want to provision infrastructure"
}