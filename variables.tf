# Xosphere Instance Orchestration Org RI sub-acct reporter
variable "xosphere_mgmt_account_ids" {
  description = "List of all AWS Account IDs of the Xosphere management accounts"
  type = list(string)
}
