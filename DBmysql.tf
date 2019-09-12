resource "aws_db_subnet_group" "myapp-db" {
    name = "main"
    description = "Our main group of subnets"
    subnet_ids = ["${aws_subnet.PrivateSubnet3.id}", "${aws_subnet.PrivateSubnet4.id}"]
    tags = {
        Name = "DB_subnet_grp"
    }
}
resource "aws_db_instance" "sec-rds" {
    identifier = "myappdb-rds"
    allocated_storage = 10
    engine = "${var.engine}"
    engine_version = "${var.engine_version}"
    instance_class = "${var.instance_class}"
    name = "myappdb"
    username = "${var.RDS_username}"
    password = "${var.RDS_PASSWORD}"
    vpc_security_group_ids = ["${aws_security_group.MySQL_DB.id}"]
    db_subnet_group_name = "${aws_db_subnet_group.myapp-db.name}"
    parameter_group_name = "default.mysql5.7"
    availability_zone = "${element(var.availability_zones, 0)}"
    tags = {
        Name = "aws_DB"
    }
}