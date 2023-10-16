terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group_rule" "good_inbound_rule" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["10.11.12.13/0"]
  security_group_id = "fake_id0"
}

resource "aws_security_group_rule" "tcp_allow_all_inbound_rule" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0","10.11.12.13/0"]
  security_group_id = "fake_id1"
}

resource "aws_security_group_rule" "tcp_allow_all_outbound_rule" {
  type = "egress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0","10.11.12.13/0"]
  security_group_id = "fake_id1"
}

resource "aws_security_group_rule" "udp_allow_all_inbound_rule" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "udp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "fake_id4"
}

resource "aws_security_group_rule" "udp_allow_all_outbound_rule" {
  type = "egress"
  from_port = 22
  to_port = 22
  protocol = "udp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "fake_id5"
}