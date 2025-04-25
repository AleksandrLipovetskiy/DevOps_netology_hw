locals {
  vm_web_name_all = "${var.vpc_name}-${var.vm_web_name_platform}"
  vm_db_name_all  = "${var.vpc_db}-${var.vm_db_name_platform}"
}