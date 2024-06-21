# WIP: Service is failing to pull image

provider "aws" {
  region = "us-west-2"
}

resource "tls_private_key" "jays_server" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jays_server" {
  key_name   = "JaysServer"
  public_key = tls_private_key.jays_server.public_key_openssh
}

resource "local_file" "jays_server_ssh_key" {
  # TODO: Make this system agnostic
  filename = "/Users/jay/.ssh/${aws_key_pair.jays_server.key_name}.pem"
  content = tls_private_key.jays_server.private_key_pem
  file_permission = "0400"
}

resource "aws_instance" "jays_server" {
  ami = "ami-0cf2b4e024cdb6960"
  instance_type = "t2.micro"
  key_name = aws_key_pair.jays_server.key_name

  tags = {
    Name = "JaysServer"
  }
}

resource "aws_eip" "jays_server" {
  instance = aws_instance.jays_server.id
  domain   = "vpc"
}