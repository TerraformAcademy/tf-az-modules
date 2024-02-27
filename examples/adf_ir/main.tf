module "adf" {
  source = "../../adf_irs"
  ir_azure = var.ir_azure
  ir_self_hosted = var.ir_self_hosted
  ir_ssis = var.ir_ssis
}