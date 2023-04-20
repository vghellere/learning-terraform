resource "aws_vpc" "webapp_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "WebApp"
  }
}
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.webapp_vpc.id
  cidr_block        = var.private_cidr_a
  availability_zone = var.region_a
  tags = {
    "Name" = "WebApp-private"
  }
}
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.webapp_vpc.id
  cidr_block        = var.public_cidr_a
  availability_zone = var.region_a
  tags = {
    "Name" = "WebApp-public"
  }
}
resource "aws_route_table" "webapp_rt" {
  vpc_id = aws_vpc.webapp_vpc.id
  tags = {
    "Name" = "WebApp-route-table"
  }
}
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.webapp_rt.id
}
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.webapp_rt.id
}
resource "aws_internet_gateway" "webapp_igw" {
  vpc_id = aws_vpc.webapp_vpc.id
  tags = {
    "Name" = "WebApp-gateway"
  }
}
resource "aws_route" "internet-route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.webapp_rt.id
  gateway_id             = aws_internet_gateway.webapp_igw.id
}
resource "aws_network_interface" "webapp_nic" {
  subnet_id       = aws_subnet.public.id
  private_ips     = ["10.0.0.120"]
  security_groups = [aws_security_group.web-pub-sg.id]
  tags = {
    "Name" = "WebApp-nic"
  }
}
resource "aws_eip" "ip-one" {
  vpc               = true
  network_interface = aws_network_interface.webapp_nic.id
  tags = {
    "Name" = "WebApp-ip"
  }
}