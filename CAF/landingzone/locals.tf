locals {
  tag_list = ["WorkloadName", "Environment", "Owner", "DeployedBy"]
  tags = {
    "WorkloadName" : "fds",
    "Environment" : var.environment,
    "Owner" : var.owner,
    "DeployedBy" : var.DeployedBy
  }
}
