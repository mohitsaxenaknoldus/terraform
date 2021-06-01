variable "availability_zone" {
  #type    = list(string)
  default = ["us-east-1"]
}
variable "instance_type" {
  #type    = list(string)
  default = ["t2.micro"]
}
variable sub{
 type = string
}
resource "aws_instance" "instance1" {
    ami = "ami-0b9064170e32bde34"
    instance_type = "t2.micro"
    subnet_id = var.sub
    tags = {
      Name = "instance"
    }
}

resource "aws_iam_instance_profile" "test_profile_1" {
  name = "test_profile_1"
  role = "${aws_iam_role.test_role.name}"
}

resource "aws_iam_role" "test_role" {
  name = "test_role1455"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = aws_iam_role.test_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::mohitcapstonebucket",
                "arn:aws:s3:::mohitcapstonebucket/*"
            ]
        },
    ]
  })
}

variable "versioning" {
  default = true
}

resource "aws_s3_bucket" "mohitcapstonebucket" {
  bucket = "mohitcapstonebucket"
  acl    = "private"

  tags = {
    Name        = "mohitcapstonebucket-2"
    Environment = "Dev"
  }
}

