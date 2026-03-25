variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "sqs_queue_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
