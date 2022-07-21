locals {
  tag_list = ["WorkloadName", "Environment", "Owner", "DeployedBy"]
  tags = {
    "WorkloadName" : "Kimmymore",
    "Environment" : var.environment,
    "Owner" : var.owner,
    "DeployedBy" : var.DeployedBy
  }
}
