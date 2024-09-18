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

variable "volume_efs_name" {
   default = "efs-airflow"
}

variable "volume_efs_root_directory" {
   default = "/data/airflow"
}

variable "volume_efs_selenium" {
   default = "/data/selenium"
}

variable "airflow_local_folder_dags" {
   default = "/usr/local/airflow/dags"
}

variable "selenium_download_folder" {
  default = "/home/seluser/Downloads"
}

