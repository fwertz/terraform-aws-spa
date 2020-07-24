# spa/locals
# https://www.terraform.io/docs/enterprise/guides/recommended-practices/part1.html
# https://medium.com/@diogok/terraform-workspaces-and-locals-for-environment-separation-a5b88dd516f5

locals {
  region           = "us-east-1"
  s3_origin_id     = "myS3Origin"
  site_url_dash = "${replace(var.site_url, ".", "-")}"
  origin_bucket    = "${local.site_url_dash}-origin"
  log_bucket       = "${local.site_url_dash}-cloudfront-log"
}
