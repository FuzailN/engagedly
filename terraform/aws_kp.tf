############################################################
       # creating ssh-key
#############################################################

resource "aws_key_pair" "engagedly-key" {
  key_name   = "engagedly-key"
  public_key = file("${path.module}/id_rsa.pub")
}
