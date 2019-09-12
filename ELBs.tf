resource "aws_elb" "ElasticLoadBalancer1" {
  name               = "ElasticLoadBalancer1"
  subnets  = ["${aws_subnet.PublicSubnet1.id}", "${aws_subnet.PublicSubnet2.id}"]
  security_groups    = ["${aws_security_group.SGelb.id}"]
  health_check {
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    timeout             = "5"
    target              = "HTTP:80/"
    interval            = "30"
  }
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  internal                    = false
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "elb-1"
  }
}
resource "aws_elb" "ElasticLoadBalancer2" {
  name               = "ElasticLoadBalancer2"
  subnets  = ["${aws_subnet.PrivateSubnet1.id}", "${aws_subnet.PrivateSubnet2.id}"]
  security_groups    = ["${aws_security_group.SGelb.id}"]
  health_check {
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    timeout             = "5"
    target              = "HTTP:80/"
    interval            = "30"    
  
  }
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  internal                    = false
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "elb-2"
  }
}