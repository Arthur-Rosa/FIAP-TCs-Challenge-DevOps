output "sqs_queue_url" {
  description = "SQS queue URL"
  value       = aws_sqs_queue.main.url
}

output "sqs_queue_arn" {
  description = "SQS queue ARN"
  value       = aws_sqs_queue.main.arn
}

output "sqs_queue_name" {
  description = "SQS queue name"
  value       = aws_sqs_queue.main.name
}

output "sqs_dlq_arn" {
  description = "SQS Dead Letter Queue ARN"
  value       = aws_sqs_queue.dlq.arn
}
