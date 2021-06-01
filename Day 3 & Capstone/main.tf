terraform {
  required_version = ">= 0.15.0"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

#variable "ec2_id" {}

module "ec2-instance"{
 source= "./ec2-instance"
 #iam_instance_profile = iam.aws_iam_instance_profile.test_profile_1.name
 instance_type = "t2.micro"
 availability_zone = "us-east-1"
 #key_name = terraformkey1
 #ec2_id = module.aws.aws_instance.instance1.public_ip
 sub = module.vpc.subnet_aws_id
}


module "vpc"{
 source= "./vpc"
}

# Just a sample that how we can use module from terraform registry 
# Unique name given by terraform itself.
module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "2.2.0"
}

# output "instance_ip" {
#   value = module.aws.public_ip
# }