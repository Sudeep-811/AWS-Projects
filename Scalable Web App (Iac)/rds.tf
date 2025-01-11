
resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  identifier           = "webappdb"
  username             = var.db_username
  password             = var.db_password
  publicly_accessible  = true
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.Private_SG.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name

  tags = {
    Name = "webapp-rds"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.private_C.id , aws_subnet.private_D.id]

  tags = {
    Name = "db-subnet-group"
  }
}

