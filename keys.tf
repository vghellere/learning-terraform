resource "aws_key_pair" "ssh_key_1" {
  key_name   = "ssh_key_1"
  public_key = file("${abspath(path.cwd)}/keys/my_key.pub")
}