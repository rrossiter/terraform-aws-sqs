variable "queues_arguments" {
  type = list(object({
    name                        = string
    delay_seconds               = optional(number, 5)
    max_message_size            = optional(number, 2048)
    message_retention_seconds   = optional(number, 86400)
    receive_wait_time_seconds   = optional(number, 10)
    max_receive_count           = optional(number, 4)
    create_dlq                  = optional(bool, false)
    fifo_queue                  = optional(bool, false)
    content_based_deduplication = optional(bool, false)
    high_throughput             = optional(bool, false)
    deduplication_scope         = optional(string, "messageGroup")
    fifo_throughput_limit       = optional(string, "perMessageGroupId")
  }))
}

variable "kms_master_key_id" {
  type        = string
  description = "(optional) ID de uma chave KMS personalizada"
}