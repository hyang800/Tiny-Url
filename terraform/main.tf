provider "aws" {
  profile    = "default"
  region     = "us-west-1"
}

resource "aws_iam_role" "web_iam_role" {
    name = "web_iam_role"
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

resource "aws_iam_instance_profile" "web_instance_profile" {
    name = "web_instance_profile"
    role = "web_iam_role"
}

resource "aws_iam_role_policy" "web_iam_role_policy" {
  name = "web_iam_role_policy"
  role = "${aws_iam_role.web_iam_role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["arn:aws:s3:::hyang800"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": ["arn:aws:s3:::hyang800/*"]
    }
  ]
}
EOF
}

resource "aws_s3_object" "object" {
    bucket = "hyang800"
    key = "app.py"
    source = "D:/USC/TinyUrl/github/TinyUrl/TinyUrl/app.py"
}

resource "aws_s3_object" "object2" {
    bucket = "hyang800"
    key = "init_db.py"
    source = "D:/USC/TinyUrl/github/TinyUrl/TinyUrl/init_db.py"
}

resource "aws_s3_object" "object3" {
    bucket = "hyang800"
    key = "schema.sql"
    source = "D:/USC/TinyUrl/github/TinyUrl/TinyUrl/schema.sql"
}

resource "aws_s3_object" "object4" {
    bucket = "hyang800"
    key = "base.html"
    source = "D:/USC/TinyUrl/github/TinyUrl/TinyUrl/templates/base.html"
}

resource "aws_s3_object" "object5" {
    bucket = "hyang800"
    key = "data.html"
    source = "D:/USC/TinyUrl/github/TinyUrl/TinyUrl/templates/data.html"
}

resource "aws_s3_object" "object6" {
    bucket = "hyang800"
    key = "index.html"
    source = "D:/USC/TinyUrl/github/TinyUrl/TinyUrl/templates/index.html"
}

resource "aws_instance" "example" {
  ami           = "ami-00d8a762cb0c50254"
  instance_type = "t2.micro"
  key_name = "hyang_12_27"
  iam_instance_profile = "${aws_iam_instance_profile.web_instance_profile.id}"
  user_data = templatefile("setup.sh",{})
}