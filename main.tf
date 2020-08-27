resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain" "elasticsearch_sg" {
  domain_name           = "${var.es_domain}"
  elasticsearch_version = "${var.es_version}"
  depends_on = [aws_iam_service_linked_role.es]

  vpc_options {
    security_group_ids = "[]"
    subnet_ids = "[]"
    access_policies = <<CONFIG
    {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Principal": {
              "AWS": [
                "*"
              ]
            },
            "Action": [
              "es:*"
            ],
            "Resource": "${aws_elasticsearch_domain.elasticsearch_sg.arn}/*"
          }
        ]
      }
    CONFIG
  }

  cluster_config {
    instance_type = "${var.es_instance_type}"
    instance_count = "${var.es_instance_count}"
    dedicated_master_enabled = "${var.es_dedicated_master_count > 0 ? true : false}"
    dedicated_master_count = "${var.es_dedicated_master_count}"
    dedicated_master_type = "${var.es_dedicated_master_type}"
  }

  ebs_options {
    ebs_enabled = "${var.ebs_volume_size > 0 ? true : false}"
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
  }

  snapshot_options {
    automated_snapshot_start_hour = "${var.es_snapshot_hour}"
  }

  tags = "${var.tags}"
}
