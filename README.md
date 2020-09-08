# Elasticsearch Module

This module will help you in creating VPC elasticsearch domain. It will create:
1.	Elasticsearch Domain (VPC)
2.	Security Group
3.	Domain policy
4.	Service linked role for elasticsearch

## Usage

```
module "elasticsearch" {
	  source                  = "github.com/moneysmartco/tf-aws-elasticsearch.git?ref=v1.x"
	  es_domain               = "${var.es_domain}"
	  es_version              = "${var.es_version}"
	  es_instance_type        = "${var.es_instance_type}"
	  es_instance_count       = "${var.es_instance_count}"
	  ebs_volume_size         = "${var.ebs_volume_size}"
	  tags                    = "${var.tags}"
	  account_id              = "${var.account_id}"
	  vpc_id                  = "${var.vpc_id}"
	  public_subnet_ids       = "${element(split(",", var.public_subnet_ids), 0)}"
	  app_sg_ids              = "${var.sg_ids != "" ? var.sg_ids : data.terraform_remote_state.eks_foundation.worker_node_security_group_id }"
	  security_group_tags     = "${var.security_group_tags}"
}
```

Note: This will create 1 node. If multinode and multizone is required, zoneawareness has to be enabled.
