resource "aws_launch_configuration" "LaunchConfig" {
  image_id        = "${var.imageID}"
  instance_type   = "${var.InstanceType}"
  security_groups = [aws_security_group.WebserverSecurityGroup.id]
  user_data       = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "80" &
              EOF  
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "WebServerGroup" {
  launch_configuration = aws_launch_configuration.LaunchConfig.id
  vpc_zone_identifier  = ["${aws_subnet.PublicSubnet1.id}", "${aws_subnet.PublicSubnet2.id}"]
  min_size             = 1
  max_size             = 2
  tag {
    key                 = "Name"
    value               = "webserver-asg"
    propagate_at_launch = true
  }
}