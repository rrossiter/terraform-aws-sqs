
locals {
  queues_arguments = {
    for queue in var.queues_arguments : queue.name => {
      name                        = queue.fifo_queue ? "${queue.name}.fifo" : queue.name
      create_dlq                  = queue.create_dlq
      delay_seconds               = queue.delay_seconds
      max_message_size            = queue.max_message_size
      max_receive_count           = queue.max_receive_count
      message_retention_seconds   = queue.message_retention_seconds
      receive_wait_time_seconds   = queue.receive_wait_time_seconds
      fifo_queue                  = queue.fifo_queue
      content_based_deduplication = queue.fifo_queue == true ? true : null
      high_throughput             = queue.high_throughput == true ? queue.high_throughput : null
      deduplication_scope         = queue.deduplication_scope
      fifo_throughput_limit       = queue.fifo_throughput_limit
    }
  }
}


resource "aws_sqs_queue" "events_queue" {
  for_each                    = local.queues_arguments
  name                        = each.value.name
  kms_master_key_id           = var.kms_master_key_id
  delay_seconds               = each.value.delay_seconds
  max_message_size            = each.value.max_message_size
  message_retention_seconds   = each.value.message_retention_seconds
  receive_wait_time_seconds   = each.value.receive_wait_time_seconds
  fifo_queue                  = each.value.fifo_queue
  content_based_deduplication = each.value.fifo_queue == true && each.value.high_throughput == false ? each.value.content_based_deduplication : null
  deduplication_scope         = each.value.fifo_queue == true && each.value.high_throughput == true ? each.value.deduplication_scope : null
  fifo_throughput_limit       = each.value.fifo_queue == true && each.value.high_throughput == true ? each.value.fifo_throughput_limit : null

  redrive_policy = each.value.create_dlq == true ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.events_deadletter_queue[each.key].arn
    maxReceiveCount     = each.value.max_receive_count
  }) : null

}

resource "aws_sqs_queue_policy" "events_queue_policy" {
  for_each  = local.queues_arguments
  queue_url = aws_sqs_queue.events_queue[each.key].url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowAll"
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl",
        ]
        Resource = aws_sqs_queue.events_queue[each.key].arn
      }
    ]
  })
}

resource "aws_sqs_queue" "events_deadletter_queue" {
  for_each                    = { for q in var.queues_arguments : q.name => q if q.create_dlq == true }
  name                        = each.value.fifo_queue == true ? "${each.value.name}-dlq.fifo" : "${each.value.name}-dlq"
  delay_seconds               = each.value.delay_seconds
  kms_master_key_id           = var.kms_master_key_id
  max_message_size            = each.value.max_message_size
  message_retention_seconds   = each.value.message_retention_seconds
  receive_wait_time_seconds   = each.value.receive_wait_time_seconds
  fifo_queue                  = each.value.fifo_queue
  content_based_deduplication = each.value.fifo_queue == true && each.value.high_throughput == false ? each.value.content_based_deduplication : null
  deduplication_scope         = each.value.high_throughput == true ? each.value.deduplication_scope : null
  fifo_throughput_limit       = each.value.high_throughput == true ? each.value.fifo_throughput_limit : null
}

output "sqs_queues" {
  value = aws_sqs_queue.events_queue
}


