variable "aws_region" {
   default = "us-east-2"
}

variable "availability_zones" {
   type    = list(string)
   default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "project_name" {
   default = "airflow"
}

variable "stage" {
   default = "dev"
}

variable "base_cidr_block" {
   default = "10.0.0.0"
}

variable "log_group_name" {
   default = "ecs/fargate"
}

variable "image_version" {
   default = "latest"
}

variable "metadata_db_instance_type" {
   default = "db.t3.micro"
}

variable "celery_backend_instance_type" {
   default = "cache.t3.small"
}