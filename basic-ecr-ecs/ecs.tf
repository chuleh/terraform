# app

data "template_file" "chuleh-io-task-definition-template" {
  template               = "${file("templates/app.json.tpl")}"
  vars {
    REPOSITORY_URL = "${replace("${aws_ecr_repository.chuleh-io.repository_url}", "https://", "")}"
  }
}

resource "aws_ecs_task_definition" "chuleh-io-task-definition" {
  family                = "chuleh-io"
  container_definitions = "${data.template_file.chuleh-io-task-definition-template.rendered}"
}
