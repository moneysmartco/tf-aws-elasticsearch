resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
}

resource "aws_security_group" "es_security_group" {
  name        = "${var.es_domain}-sg"
  description = "Security group for elasticsearch"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["split(",","${var.app_sg_ids}")"]
    self            = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = "${var.security_group_tags}"
}

resource "aws_elasticsearch_domain_policy" "main" {
  domain_name = "${aws_elasticsearch_domain.elasticsearch_sg.domain_name}"
  access_policies = <<POLICIES
  {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "AWS": [
              "${var.account_id}"
            ]
          },
          "Action": [
            "es:*"
          ],
          "Resource": "${aws_elasticsearch_domain.elasticsearch_sg.arn}/*"
          }
        ]
      }
  POLICIES
}


resource "aws_elasticsearch_domain" "elasticsearch_sg" {
  domain_name           = "${var.es_domain}"
  elasticsearch_version = "${var.es_version}"
  depends_on = ["aws_iam_service_linked_role.es"]

  vpc_options {
    security_group_ids = ["${aws_security_group.es_security_group.id}"]
    subnet_ids = ["${var.public_subnet_ids}"]
  }

  cluster_config {
    instance_type = "${var.es_instance_type}"
    instance_count = "${var.es_instance_count}"
    #dedicated_master_enabled = "${var.es_dedicated_master_count > 0 ? true : false}"
    #dedicated_master_count = "${var.es_dedicated_master_count}"
    #dedicated_master_type = "${var.es_dedicated_master_type}"
  }

  ebs_options {
    ebs_enabled = "${var.ebs_volume_size > 0 ? true : false}"
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
  }

  /*snapshot_options {
    automated_snapshot_start_hour = "${var.es_snapshot_hour}"
  }*/

  tags = "${var.tags}"
}
