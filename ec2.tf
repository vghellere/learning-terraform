resource "aws_security_group" "web-pub-sg" {
  name        = "allow_web_access"
  description = "allow inbound traffic"
  vpc_id      = aws_vpc.webapp_vpc.id

  ingress {
    description = "allow traffic on port 80"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow traffic on port 443"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow traffic on port 22"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }
  tags = {
    "Name" = "WebApp-sg"
  }
}

resource "aws_instance" "web-server1" {
  depends_on = [
    aws_key_pair.ssh_key_1
  ]
  instance_type               = "t2.micro"
  ami                         = "ami-007855ac798b5175e"
  vpc_security_group_ids      = [aws_security_group.web-pub-sg.id]
  subnet_id                   = aws_subnet.public.id
  private_ip                  = "10.0.0.122"
  associate_public_ip_address = true
  key_name                    = "ssh_key_1"
  tags = {
    Name = "app-server-1"
  }
}
