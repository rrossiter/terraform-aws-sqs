<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_create_sqs_queues"></a> [create\_sqs\_queues](#module\_create\_sqs\_queues) | ../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_master_key_id"></a> [kms\_master\_key\_id](#input\_kms\_master\_key\_id) | (optional) ID de uma chave KMS personalizada | `string` | n/a | yes |
| <a name="input_queues_arguments"></a> [queues\_arguments](#input\_queues\_arguments) | n/a | <pre>list(object({<br>    name                        = string<br>    delay_seconds               = optional(number, 5)<br>    max_message_size            = optional(number, 2048)<br>    message_retention_seconds   = optional(number, 86400)<br>    receive_wait_time_seconds   = optional(number, 10)<br>    max_receive_count           = optional(number, 4)<br>    create_dlq                  = optional(bool, false)<br>    fifo_queue                  = optional(bool, false)<br>    content_based_deduplication = optional(bool, false)<br>    high_throughput             = optional(bool, false)<br>    deduplication_scope         = optional(string, "messageGroup")<br>    fifo_throughput_limit       = optional(string, "perMessageGroupId")<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->