variable "domain_name" {
  description = "Domain name for Elasticsearch cluster"
  type        = string
  default     = "msmart-es"
}
variable "es_version"{
  description = "The version of Elasticsearch to deploy."
  type        = string
  default     = "7.7"
}
variable "es_instance_type"{
  description = "Instance type of data nodes in the cluster"
  type        = string
  default     = "t2.small.elasticsearch"
}
variable "es_instance_count"{
  description = "Number of instances in the cluster"
  type        = number
  default     = "1"
}
variable "es_dedicated_master_count"{
  description = "Number of dedicated master nodes in the cluster"
  type        = number
  default     = "0"
}
variable "es_dedicated_master_type"{
  description = "Instance type of the dedicated master nodes in the cluster."
  type        = string
  default     = ""
}
variable "ebs_volume_size"{
  description = "The size of EBS volumes attached to data nodes (in GB)"
  type        = number
  default     = "30"
}
variable "ebs_volume_type"{
  description = "The type of EBS volumes attached to data nodes"
  type        = string
  default     = ""
}
variable "es_snapshot_hour"{
  description = "Hour during which the service takes an automated daily snapshot of the indices in the domain."
  type        = number
  default     = "0"
}
variable "tags"{
  type = map(string)
  default = {
      Team = "Discovery"
      Environment = "Staging"
   }
}
