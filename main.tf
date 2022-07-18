locals {
  lambda_function__xosphere_organization_ri_sub_account_reporter = "xosphere-org-ri-sub-acct-reporter"

  xosphere_mgmt_account_arns = formatlist("\"arn:aws:iam::%s:root\"", var.xosphere_mgmt_account_ids)
}

resource "aws_iam_role" "xosphere_organization_ri_sub_account_reporter_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Sid": "AllowAssumeFromXosphereManagementAccount",
    "Action": "sts:AssumeRole",
    "Effect": "Allow",
    "Principal": {
      "AWS": [ ${join(",", local.xosphere_mgmt_account_arns)} ]
    }
  }
}
EOF
  managed_policy_arns = [ ]
  path = "/"
  name = "${local.lambda_function__xosphere_organization_ri_sub_account_reporter}-lambda-assume-role"
}

resource "aws_iam_role_policy" "xosphere_organization_ri_sub_account_reporter_role_policy" {
  name = "${local.lambda_function__xosphere_organization_ri_sub_account_reporter}-lambda-policy"
  role = aws_iam_role.xosphere_organization_ri_sub_account_reporter_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowOperationsWithoutResourceRestrictions",
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeRegions",
        "ec2:DescribeReservedInstances"
	    ],
      "Resource": "*"
    }
  ]
}
EOF
}
