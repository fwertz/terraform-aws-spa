# spa/acm

data "aws_route53_zone" "zone" {
  name = "${var.top_level_domain != "" ? var.top_level_domain : var.site_url}."
}

resource "aws_acm_certificate" "cert" {
  domain_name               = "*.${var.site_url}"
  subject_alternative_names = ["${var.site_url}"]
  validation_method         = "DNS"
  tags = {
    SEISAN_CLIENT = var.client_tag
  }
}

resource "aws_route53_record" "cert_validation" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.zone.id}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}

output "cert_arn" {
  value = "${aws_acm_certificate.cert.arn}"
}
