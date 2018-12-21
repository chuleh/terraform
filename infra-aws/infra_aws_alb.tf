## define ALB
#resource "aws_elb" "infra_aws_elb" {
#  name = "infra-aws-alb"
#  availability_zones = ["${var.availability_zones[count.index]}"]
#  access_logs {
#    bucket = "foo"
#    bucket_prefix = "bar"
#    interval = 60
#  }
#
#  listener {
#    instance_port = 8000
#    instance_protocol = "http"
#    lb_port = 80
#    lb_protocol = "http"
#  }
#  health_check {
#    healthy_threshold = 2
#    unhealthy_threshold = 2
#    timeout = 3
#    target = "HTTP:8000/"
#    interval = 30
#  }
#  #instances                   = ["${element(aws_instance.aws_infra_webservers.*.id, count.index)}"]
#  #instances = ["${aws_instance.aws_infra_webservers[count.index]}"]
#  instances = ["${aws_instance.aws_infra_webservers.id}"]
#  cross_zone_load_balancing   = true
#  idle_timeout                = 400
#  connection_draining         = true
#  connection_draining_timeout = 400
#}
