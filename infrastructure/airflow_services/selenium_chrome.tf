resource "aws_security_group" "selenium" {
    name        = "${var.project_name}-${var.stage}-selenium-sg"
    description = "Allow all inbound traffic for Selenium"
    vpc_id      = aws_vpc.vpc.id

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.project_name}-${var.stage}-selenium-sg"
    }
}

resource "aws_ecs_task_definition" "selenium" {
    family                   = "${var.project_name}-${var.stage}-selenium"
    network_mode             = "awsvpc"
    execution_role_arn       = aws_iam_role.ecs_task_iam_role.arn
    task_role_arn            = aws_iam_role.ecs_task_iam_role.arn
    requires_compatibilities = ["FARGATE"]
    cpu                      = "512"
    memory                   = "2048"

    container_definitions = jsonencode([{
        name      = "selenium"
        image     = "selenium/standalone-chrome:latest"
        portMappings = [
            {
                containerPort = 4444
                hostPort      = 4444
                protocol      = "tcp"
            }
        ]
        essential = true
        mountPoints = [
            {
                sourceVolume  = var.volume_efs_name
                containerPath = var.selenium_download_folder
                readOnly      = false
            }
        ]
    }])

    volume {
        name = var.volume_efs_name
        efs_volume_configuration {
            file_system_id = aws_efs_file_system.foo.id
            transit_encryption = "ENABLED"
            authorization_config {
                access_point_id = aws_efs_access_point.selenium_access_point.id
                iam = "ENABLED"
            }
        }
    }
}
