data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "ipfs" {
  ami                    = data.aws_ami.ubuntu.image_id
  vpc_security_group_ids = [aws_security_group.ipfs.id]
  subnet_id              = aws_subnet.ipfs.id
  key_name               = aws_key_pair.aws_instance_ipfs.id
  instance_type          = "t2.micro"
}

resource "aws_key_pair" "aws_instance_ipfs" {
  key_name   = "aws_instance_ipfs"
  public_key = var.ssh_public_key
}
