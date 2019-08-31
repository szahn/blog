---
date: 2019-03-01
tags: [docker,terraform,aws,ec2,node]
draft: true
title: Deploying Node to AWS with Terraform
ThumbUrl: img/logo-terraform.png
---

# What is Terraform?

Terraform can automate the lifecycle of cloud infastructure. Docker is utilized to run a Terraform build container. The container mounts a local plan and temporary folders to share Terraform state and SSH Keys. The entry point initializes terraform. The `deploy` make command will use the build container to apply the terraform plan. The plan creates a typical VPC, with internet gateway, a route table, private and public subnets, security group allowing HTTP Port 80 traffic to the client IP, and IAM role with access to S3. The Node.JS server source code is uploaded to a private S3 bucket. When the EC2 instance is created, user data copies the Node JS source from S3, and installs the server as a service. During the EC2 instantiation, The user data script may take 30-60 seconds to install dependencies. Terraform will print the public IP address of the Node server when the plan is complete. Visit that url when the user data script finishes to view the response json.

All you need is Linux, Docker, and an AWS account to get started.

# Prerequisites

- Debian based system (Ubuntu) recommended
- Make
- Docker

# Setup

Run `sudo make generate_key` to generate RSA Keys.

Create an AWS User with Programmatic access having an AdministratorAccess policy in the AWS Console. Specify the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` in a `default.env` file at the folder root

```bash
echo "AWS_ACCESS_KEY_ID=YourAccessKey" > ./default.env
echo "AWS_SECRET_ACCESS_KEY=XXX" >> ./default.env
```

Example default.env:

```
AWS_ACCESS_KEY_ID=XXX
AWS_SECRET_ACCESS_KEY=XXX
```

## Setup for Debian Environment

Install Docker: 

```bash
apt-get update && apt install docker.io -y
```

# Testing

Run unit tests with `make test`

# Deployment

Run `sudo make deploy` to deploy AWS components. When the deployment is complete, you should be able to visit the address displayed in the `NodeServerAddress` output variable. It may take 30-60 seconds or more for the server to prepare.

# Cleanup

Run `sudo make teardown` to uninstall the deployment.



# Steps

## Create an SSH Key

```bash
@mkdir -p ./temp
@ssh-keygen -f ./temp/id_rsa -t rsa -b 4096 -q
@chmod 400 ./temp/id_rsa
```

## Terraform Build Container

To deploy AWS components using Terraform, a Terraform plan (`.tf`) is required. Configuration can be saved in a `.tfvars` file.


```
FROM hashicorp/terraform:0.12.7

ARG AWS_PROVIDER_VERSION

VOLUME ["/temp", "/plan"]

COPY ./scripts/terraform-init.sh ./terraform-init.sh
COPY ./scripts/userdata ./userdata

ENTRYPOINT ["./terraform-init.sh"]
``

### Terraform Plan

```
provider "aws" {
    region = "us-east-1"
    version = "~> 2.25"
}

data "aws_availability_zones" "available" {}

# VPC

resource "aws_vpc" "vpc" {
  cidr_block = "10.1.0.0/16"
}

# Internet gateway

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
}

# IAM Role, Profile

resource "aws_iam_role" "s3_access_role" {
  name = "s3_access_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
  },
      "Effect": "Allow",
      "Sid": ""
      }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "s3_access_profile" {
  name = "s3_access_profile"
  role = "${aws_iam_role.s3_access_role.name}"
}

# IAM S3 Access Policy

resource "aws_iam_role_policy" "s3_access_policy" {
  name = "s3_access_policy"
  role = "${aws_iam_role.s3_access_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}

# Route tables

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags = {
    Name = "public"
  }
}

# Subnets

resource "aws_subnet" "public1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.cidrs["public1"]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags = {
    Name = "public1"
  }
}

# Subnet Associations

resource "aws_route_table_association" "public1_assoc" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.public.id}"
}

#Security groups

resource "aws_security_group" "dev_sg" {
  name        = "dev_sg"
  description = "Used for ssh, http access to the node server"
  vpc_id      = "${aws_vpc.vpc.id}"

  #SSH

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.localip}/32"]
  }

  #HTTP

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "public_sg" {
  name        = "sg_public"
  vpc_id      = "${aws_vpc.vpc.id}"

  #SSH

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.localip}/32"]
  }

  #HTTP

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Outbound internet access

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# key pair

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

# server

resource "aws_s3_bucket" "bucket" {
  bucket = "stelligent-mini-project-stuart-zahn-server"
  acl    = "private"

  tags = {
    Name = "Server Source Code"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.bucket.id}"
  key    = "server.zip"
  source = "./temp/server.zip"
  etag = "${filemd5("./temp/server.zip")}"
}

resource "aws_instance" "dev" {
  instance_type = "${var.dev_instance_type}"
  ami           = "${var.dev_ami}"
  user_data            = "${file("userdata")}"

  iam_instance_profile   = "${aws_iam_instance_profile.s3_access_profile.id}"

  tags = {
    Name = "nodejs-instance"
  }

  key_name               = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.public_sg.id}"]
  subnet_id              = "${aws_subnet.public1.id}"

}

#-------OUTPUTS ------------

output "NodeServerAddress" {
  value = "http://${aws_instance.dev.public_ip}:80"
}
```

#### Variables

variables.tf

```
variable "aws_region" {}
variable "localip" {}
variable "key_name" {}
variable "public_key_path" {}
variable "dev_instance_type" {}
variable "dev_ami" {}
variable "cidrs" {
  type = "map"
}
```

#### Variable Configuration

```
aws_region        = "us-east-1"
key_name          = "id_rsa_sz"
public_key_path   = "/temp/id_rsa.pub"
dev_instance_type = "t2.micro"
dev_ami		  = "ami-07d0cf3af28718ef8"
cidrs             = {
  public1	  = "10.1.1.0/24"
}
```

### Dockerfile

```dockerfile
FROM hashicorp/terraform:0.12.7

ARG AWS_PROVIDER_VERSION

VOLUME ["/temp", "/plan"]

COPY ./scripts/terraform-init.sh ./terraform-init.sh
COPY ./scripts/userdata ./userdata

ENTRYPOINT ["./terraform-init.sh"]
```

```bash
#!/bin/sh

terraform init ./plan

eval "$@"
```

## EC2 Initialization

```bash
#!/bin/bash
apt update -y
apt install python nodejs npm unzip -y
curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip
unzip awscli-bundle.zip
./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
aws s3 cp s3://stelligent-mini-project-stuart-zahn-server/server.zip ./
unzip ./server.zip
cd ./server
chmod +x ./index.js
npm install
echo "[Unit]" > /etc/systemd/system/node_server.service
echo "Description=Node Server [Service]" >> /etc/systemd/system/node_server.service
echo "[Service]" >> /etc/systemd/system/node_server.service
cwd=$(pwd) && echo "ExecStart=$cwd/index.js" >> /etc/systemd/system/node_server.service
echo "Restart=always" >> /etc/systemd/system/node_server.service
echo "KillSignal=SIGQUIT" >> /etc/systemd/system/node_server.service
cwd=$(pwd) && echo "WorkingDirectory=$cwd" >> /etc/systemd/system/node_server.service
echo "[Install]" >> /etc/systemd/system/node_server.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/node_server.service
systemctl enable node_server.service
systemctl start node_server.service
```

## Make file

```
BASE_PATH:=$(shell pwd)
MY_IP:=$(shell curl -s -4 icanhazip.com)

# Warning: removes TF state and keys
cleanup:
	rm -rf  ./temp

generate_key:
	@mkdir -p ./temp
	@ssh-keygen -f ./temp/id_rsa -t rsa -b 4096 -q
	@chmod 400 ./temp/id_rsa

package_server:
	@rm -f ./temp/temp/server.zip
	@zip ./temp/server.zip -r server -x "*node_modules*"

test:
	cd server && npm run test

build:
	@docker build -t terraform .

deploy: build package_server
	docker run -it --rm -v $(BASE_PATH)/temp:/temp -v $(BASE_PATH)/plan:/plan --env-file ./default.env terraform \
		"terraform apply -auto-approve -state=/temp/terraform.tfstate -var 'localip=$(MY_IP)' -var-file=./plan/staging.tfvars ./plan"

teardown:
	@docker run -it --rm -v $(BASE_PATH)/temp:/temp -v $(BASE_PATH)/plan:/plan --env-file ./default.env terraform \
		"terraform destroy -auto-approve -state=/temp/terraform.tfstate -var 'localip=$(MY_IP)' -var-file=./plan/staging.tfvars ./plan"

```