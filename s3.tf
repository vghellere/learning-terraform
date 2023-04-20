resource "aws_s3_bucket" "webapp_bucket" {
  bucket = "vghellere-webapp-storage"

  tags = {
    Name = "WebApp"
  }
}