# Dead Letter Queue for unprocessable messages
resource "aws_sqs_queue" "dlq" {
  name                      = "${var.sqs_queue_name}-dlq"
  message_retention_seconds = 1209600 # 14 days

  tags = merge(var.tags, {
    Name    = "${var.sqs_queue_name}-dlq"
    Service = "evaluation-service"
  })
}

# Main SQS Queue
resource "aws_sqs_queue" "main" {
  name                       = var.sqs_queue_name
  delay_seconds              = 0
  max_message_size           = 262144 # 256 KB
  message_retention_seconds  = 86400  # 1 day
  receive_wait_time_seconds  = 20     # Long polling
  visibility_timeout_seconds = 30

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })

  tags = merge(var.tags, {
    Name    = var.sqs_queue_name
    Service = "evaluation-service"
  })
}

# SQS Queue Policy (allow EKS service accounts to send/receive)
resource "aws_sqs_queue_policy" "main" {
  queue_url = aws_sqs_queue.main.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowSendReceiveDelete"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl"
        ]
        Resource = aws_sqs_queue.main.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = "arn:aws:iam::*:role/*"
          }
        }
      }
    ]
  })
}
