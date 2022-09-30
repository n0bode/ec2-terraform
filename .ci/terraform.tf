provider "aws" {
    region = var.region
}

terraform {
  backend "s3" {
  }
}

resource "aws_subnet" "private_a"{
    vpc_id = var.vpc_id
    cidr_block = "172.31.120.0/24"

    tags = {
        Name = "sub-private-${var.stage}-a"
    }
}

resource "aws_subnet" "public_a"{
    vpc_id = var.vpc_id
    cidr_block = "172.31.244.0/24"

    tags = {
        Name = "sub-public-${var.stage}-a"
    }
}

resource "aws_nat_gateway" "nat"{
    connectivity_type = "private"
    subnet_id = aws_subnet.private_a.id
}

resource "aws_route_table" "rt_nat" {
    vpc_id = var.vpc_id

    tags = {
        Name = "route table to natgateway"
    }
}
resource "aws_security_group" "sg_maquina"{
    name = "regras-webapp-${var.stage}"
    description = "security group da maquina ec2 da aplicacao em ${var.stage}"
    vpc_id = var.vpc_id

    ingress {
        from_port = 80
        protocol = "tcp"
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        protocol = "tcp"
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "maquina"{
    ami = "ami-017fecd1353bcc96e"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public_a.id
    key_name = var.keypair

    vpc_security_group_ids = [
        aws_security_group.sg_maquina.id
    ]

    tags = {
        Name = "applicacao-web-${var.stage}"
    }
    associate_public_ip_address = true
    
    user_data = file("./push.sh")
}