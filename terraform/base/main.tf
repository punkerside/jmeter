module "main" {
  source  = "punkerside/vpc/aws"
  version = "0.0.6"

  name           = "${var.project}-${var.env}"
  cidr_block_vpc = "10.0.0.0/16"
  cidr_block_pri = ["10.0.0.0/18", "10.0.64.0/18"]
  cidr_block_pub = ["10.0.128.0/18", "10.0.192.0/18"]
}

resource "aws_iam_role" "main" {
  name               = "${var.project}-${var.env}-${var.service}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "${var.project}-${var.env}-${var.service}"
  }
}

resource "aws_iam_role_policy" "main" {
  name = "${var.project}-${var.env}-${var.service}"
  role = aws_iam_role.main.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "ssm:*",
        "ec2messages:*",
        "ssmmessages:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "main" {
  name = "${var.project}-${var.env}-${var.service}"
  role = aws_iam_role.main.name
}

resource "aws_security_group" "main" {
  name        = "${var.project}-${var.env}-${var.service}"
  description = "inbound traffic"
  vpc_id      = module.main.vpc.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-${var.env}-${var.service}"
  }
}