# spa/variables

variable "site_url" {}
variable "top_level_domain" {
  default = "${site_url}"
}

variable "force_destroy" {
  default = false
}
