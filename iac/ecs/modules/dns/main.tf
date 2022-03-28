resource "aws_route53_zone" "dns_zone" {
    name = "${var.zone_name}"
}

resource "aws_route53_record" "myRecord" {
    zone_id = aws_route53_zone.dns_zone.zone_id
    name    = "${var.sub_domain}.${var.zone_name}"
    type    = "CNAME"
    ttl     = 60
    records = [var.lb_dns_name]
}