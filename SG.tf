resource "aws_security_group" "WebserverSecurityGroup" {
  name = "terraform-instance"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.ip_range}"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.ip_range}"
  }
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks ="${var.ip_range}"
  }
  vpc_id = "${aws_vpc.vpc_Me.id}"
  tags = {
    Name = "Webserver_SG"
  }
}
resource "aws_security_group" "SGelb" {
  name = "terraform-elb" # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.ip_range}"
  }
  # Inbound HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.ip_range}"
    security_groups = ["${aws_security_group.WebserverSecurityGroup.id}"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.ip_range}"
  }
  vpc_id = "${aws_vpc.vpc_Me.id}"
  tags = {
    Name = "SG_elb"
  }
}
resource "aws_security_group" "MySQL_DB" {
    name = "MySQL_DB"
  tags = {
    Name = "MySQL_DB"
  }
  description = "ONLY tcp CONNECTION INBOUND"
  vpc_id = "${aws_vpc.vpc_Me.id}"
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "TCP"
    security_groups = ["${aws_security_group.WebserverSecurityGroup.id}"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = "${var.ip_range}"
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = "${var.ip_range}"
  }
}