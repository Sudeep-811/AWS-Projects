
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "web-app-vpc"
  }
}

resource "aws_subnet" "public_A" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.aws_az_public_A}"
  map_public_ip_on_launch = false
  tags = {
    Name = "public-subnet-A"
  }
}

resource "aws_subnet" "public_B" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "${var.aws_az_public_B}"
  map_public_ip_on_launch = false

    tags = {
    Name = "public-subnet-B"
  }
}

resource "aws_subnet" "private_C" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "${var.aws_az_private_C}"

  tags = {
    Name = "private-subnet-C"
  }
}

resource "aws_subnet" "private_D" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.15.0/24"
  availability_zone = "${var.aws_az_public_B}"

  tags = {
    Name = "private-subnet-D"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public_A.id
}

resource "aws_eip" "main" {
  associate_with_private_ip = true
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_A" {
  subnet_id      = aws_subnet.public_A.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_B" {
  subnet_id      = aws_subnet.public_B.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "private_to_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

resource "aws_route_table_association" "private_association_C" {
  subnet_id      = aws_subnet.private_C.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_association_D" {
  subnet_id      = aws_subnet.private_D.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "Public_SG" {
  vpc_id = aws_vpc.main.id
  name        = "Public_SG"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

    ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

    ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
}




resource "aws_security_group" "Private_SG" {
  vpc_id = aws_vpc.main.id
  name        = "Private_SG"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.Public_SG.id]
  }

  ingress {
    from_port   = 3306  
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.6.0/24"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "0"
    cidr_blocks = ["0.0.0.0/0"]
  }
}