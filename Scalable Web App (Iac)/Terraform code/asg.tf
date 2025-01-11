resource "aws_launch_template" "app" {
  name          = "app-launch-template"
  instance_type = var.instance_type
  image_id      = "ami-0fd05997b4dff7aac"

  # Security group and network interface settings
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.Public_SG.id]
    device_index                = 0
  }

  # User data for the instance
  user_data = base64encode(<<-EOT
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd
    echo "<h1>Hello, this is an instance in $(hostname -f)</h1>" > /var/www/html/index.html
    EOT
  )

  # Tagging for launch template
  tag_specifications {
    resource_type = "instance"
    
    # Set a generic name here (will be overridden by ASG tags)
    tags = {
      Name = "app-instance"  # Placeholder name
    }
  }
}

resource "aws_autoscaling_group" "app" {
  target_group_arns   = [aws_lb_target_group.app.arn]
  desired_capacity    = 2
  max_size            = 4
  min_size            = 2
  vpc_zone_identifier = [aws_subnet.public_A.id, aws_subnet.public_B.id]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  # Tagging for instances within the ASG
  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}
