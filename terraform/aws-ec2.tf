# WIP: Service is failing to pull image

provider "aws" {
  region = "us-west-2"
}
provider "docker" {
  host = "unix:///Users/jayherron/.rd/docker.sock"

  registry_auth {
    address     = "registry-1.docker.io"
    config_file = pathexpand("~/.docker/config.json")
  }

  registry_auth {
    address     = "335981579309.dkr.ecr.us-west-2.amazonaws.com"
    config_file = pathexpand("~/.docker/config.json")
  }
}

resource "aws_ecr_repository" "test" {
  name                 = "test"
}

resource "docker_image" "vaultwarden" {
  name = "vaultwarden/server"
}

resource "docker_tag" "vaultwarden" {
  source_image = docker_image.vaultwarden.name
  target_image = "${aws_ecr_repository.test.repository_url}:latest"
}

resource "docker_registry_image" "vaultwarden" {
  name          = docker_tag.vaultwarden.target_image
  keep_remotely = true
}

resource "aws_iam_role" "test_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.test_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_cluster" "test" {
  name = "test"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_cloudwatch_log_group" "test" {
  name = "test"
}

resource "aws_ecs_task_definition" "test" {
  family                   = "test"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.test_role.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "bitwarden",
    "image": "${docker_registry_image.vaultwarden.name}",
    "cpu": 1024,
    "memory": 2048,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.test.name}",
        "awslogs-region": "us-west-2",
        "awslogs-stream-prefix": "bitwarden"
      }
    }
  }
]
TASK_DEFINITION
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_ecs_service" "test" {
  name            = "test"
  cluster         = aws_ecs_cluster.test.id
  task_definition = aws_ecs_task_definition.test.arn
  desired_count   = 1
  launch_type = "FARGATE"
  # iam_role        = aws_iam_role.foo.arn

  network_configuration {
    subnets         = [aws_subnet.main.id]
    assign_public_ip = true
  }

  # ordered_placement_strategy {
  #   type  = "binpack"
  #   field = "cpu"
  # }

  # load_balancer {
  #   target_group_arn = aws_lb_target_group.foo.arn
  #   container_name   = "mongo"
  #   container_port   = 8080
  # }

  # placement_constraints {
  #   type       = "memberOf"
  #   expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  # }
}