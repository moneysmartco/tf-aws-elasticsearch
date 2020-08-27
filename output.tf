output "domain_name" {
  description = "The name of the Elasticsearch domain"
  value = "${var.es_domain}"
}
output "domain_arn"{
  description = " Amazon Resource Name (ARN) of the domain."
  value = "${aws_elasticsearch_domain.es_domain.arn}"
}
output "es_endpoint"{
  description = "Domain-specific endpoint used to submit index, search, and data upload requests."
  value = "${aws_elasticsearch_domain.es_domain.endpoint}"
}
output "kibana_endpoint"{
  description = "Domain-specific endpoint for kibana without https scheme."
  value = "${aws_elasticsearch_domain.es_domain.kibana_endpoint}"
}
