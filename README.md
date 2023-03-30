# terraform-modules-sqs
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.60.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_sqs_queue.events_deadletter_queue](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.events_queue](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.events_queue_policy](https://registry.terraform.io/providers/hashicorp/aws/4.60.0/docs/resources/sqs_queue_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_master_key_id"></a> [kms\_master\_key\_id](#input\_kms\_master\_key\_id) | (optional) ID de uma chave KMS personalizada | `string` | n/a | yes |
| <a name="input_queues_arguments"></a> [queues\_arguments](#input\_queues\_arguments) | n/a | <pre>list(object({<br>    name                        = string<br>    delay_seconds               = optional(number, 5)<br>    max_message_size            = optional(number, 2048)<br>    message_retention_seconds   = optional(number, 86400)<br>    receive_wait_time_seconds   = optional(number, 10)<br>    max_receive_count           = optional(number, 4)<br>    create_dlq                  = optional(bool, false)<br>    fifo_queue                  = optional(bool, false)<br>    content_based_deduplication = optional(bool, false)<br>    high_throughput             = optional(bool, false)<br>    deduplication_scope         = optional(string, "messageGroup")<br>    fifo_throughput_limit       = optional(string, "perMessageGroupId")<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_queues_created"></a> [queues\_created](#output\_queues\_created) | n/a |
| <a name="output_sqs_queues"></a> [sqs\_queues](#output\_sqs\_queues) | n/a |
<!-- END_TF_DOCS -->