############################################################
      # Web & DB Instance
############################################################

resource "aws_instance" "web_instance" {
  ami           = var.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.engagedly-key.key_name
  subnet_id     = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.web_sg.id]
}

resource "aws_instance" "db_instance" {
  ami           = var.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.engagedly-key.key_name
  subnet_id     = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.db_sg.id]
}

############################################################
      # Bastion Instance
############################################################

resource "aws_instance" "bastion" {
  ami             = var.image_id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.engagedly-key.key_name
  subnet_id       = aws_subnet.bastion_public_subnet.id
  security_groups = [aws_security_group.bastion_sg.id]

  associate_public_ip_address = true
}
