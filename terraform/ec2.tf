resource "aws_vpc" "Demo" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "vpc-TF"
  }
}
resource "aws_subnet" "pub" {
  vpc_id                  = aws_vpc.Demo.id
  cidr_block              = var.aws_subnet
  availability_zone       = var.aws_az[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-subnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Demo.id
  tags = {
    Name = "igw-var"
  }
}
resource "aws_route_table" "RT-PUB" {
  vpc_id = aws_vpc.Demo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "RT" {
  subnet_id      = aws_subnet.pub.id
  route_table_id = aws_route_table.RT-PUB.id

}
resource "aws_security_group" "var_sg" {
  name   = "dev-sg"
  vpc_id = aws_vpc.Demo.id

  ingress {
    from_port   = var.sg_ports[0]
    to_port     = var.sg_ports[0]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.sg_ports[1]
    to_port     = var.sg_ports[1]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.sg_ports[2]
    to_port     = var.sg_ports[2]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.sg_ports[3]
    to_port     = var.sg_ports[3]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = var.sg_ports[4]
    to_port     = var.sg_ports[4]
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "testinstance" {
  ami                    = data.aws_ami.os_image.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.pub.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.var_sg.id]
  user_data              = file("${path.module}/install_tools.sh")

  tags = {
    Name        = var.instance_tags.Name,
    Environment = var.instance_tags_dev.Environment
  }
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

}