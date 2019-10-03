---
date: 2019-03-01
tags: [docker,terraform,aws,ec2,node]
draft: false
title: Deploying Node to AWS with Terraform
ThumbUrl: img/terraform.png
---

# DevOps Automation

> A DevOps mindset requires "Highly effective, daily collaboration between software developers and IT operations people to produce relevant, working systems" &mdash;https://skeltonthatcher.com/blog/a-useful-working-definition-of-devops/

> In order to build and operate the kinds of complex, distributed software systems required for 2018 and beyond, we need to emphasize effectiveness over efficiency for technical teams. Delivering changes rapidly, reliably, and repeatedly is not possible if we aim to minimize ‘costs’ at specific points of the value chain, as this kind of efficiency usually ends up causing unnecessary constraints. Instead, we should focus on flow and completion of work in progress. &mdash;https://devops-bootcamp.liatr.io/#/1/1.1-devops-defined

# What is Terraform?

[Terraform](https://www.terraform.io/intro/index.html) is IaC (Infastructure as Code) middleware that uses declarative markup to automate the lifecycle of cloud infastructure in a cloud vendor agnostic manner. I'll be using the [AWS Provider](https://github.com/terraform-providers/terraform-provider-aws), but you could easily deploy to Azure or GCP.


# Using a Build Container

In this example, [Docker](https://docs.docker.com/get-started/) is utilized to run a Terraform build container. The benefit of containerizing a build, is isolating build dependencies from the operating system. Common CI/CD platforms like [CircleCI](https://circleci.com/product/#how-it-works) also use build containers, so this is a common approach. The container mounts a local plan and temporary folders to share Terraform state and SSH Keys. The entry point initializes Terraform. The plan creates a typical VPC, with internet gateway, a route table, private and public subnets, security group allowing HTTP Port 80 traffic to the client IP, and IAM role with access to S3. The Node.JS server source code is uploaded to a private S3 bucket. When the EC2 instance is created, user data copies the Node JS source from S3, and installs the server as a service. Terraform will print the public IP address of the Node server when the plan is complete. 

All you need is Linux, Docker, and an AWS account to get started.

Check out the [source code here](https://github.com/szahn/terraform-aws-automation).