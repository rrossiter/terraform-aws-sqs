module "create_sqs_queues" {
  # source = "git::https://github.com/rrossiter/terraform-modules-sqs.git"
  source     = "../"
  queues_arguments = var.queues_arguments
  kms_master_key_id = var.kms_master_key_id
}