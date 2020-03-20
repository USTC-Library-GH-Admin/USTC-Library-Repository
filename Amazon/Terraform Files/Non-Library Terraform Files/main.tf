############################################Identity IAM Resources###########################################################

resource "aws_iam_policy" "STS-Assume-Role-For-Member-Admins" {
  provider    = aws.ident  
  name        = "STS-Assume-Role-For-Member-Admins"
  description = "AssumeRole policy added to Member Admins Group"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "STSAssumeRoleForMemberAdmin",
      "Action": [
        "sts:AssumeRole",
        "sts:Get*",
        "sts:Decode*",
        "sts:Tag*",
        "iam:List*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_group" "SRE-MemberAdmins" {
  provider = aws.ident  
  name = "SRE-MemberAdmins"
}

resource "aws_iam_group_policy_attachment" "sre-attach1" {
  provider = aws.ident 
  group      = "${aws_iam_group.SRE-MemberAdmins.name}"
  policy_arn = "${aws_iam_policy.STS-Assume-Role-For-Member-Admins.arn}"
}

resource "aws_iam_group_policy_attachment" "sre-attach2" {
  provider = aws.ident   
  group      = "${aws_iam_group.SRE-MemberAdmins.name}"
  policy_arn = "arn:aws:iam::aws:policy/IAMSelfManageServiceSpecificCredentials"
}

resource "aws_iam_group_policy_attachment" "sre-attach3" {
  provider = aws.ident   
  group      = "${aws_iam_group.SRE-MemberAdmins.name}"
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "sre-attach4" {
  provider = aws.ident   
  group      = "${aws_iam_group.SRE-MemberAdmins.name}"
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

resource "aws_iam_group" "SBP-MemberAdmins" {
  provider = aws.ident  
  name = "SBP-MemberAdmins"
}

resource "aws_iam_group_policy_attachment" "sbp-attach1" {
  provider = aws.ident 
  group      = "${aws_iam_group.SBP-MemberAdmins.name}"
  policy_arn = "${aws_iam_policy.STS-Assume-Role-For-Member-Admins.arn}"
}

resource "aws_iam_group_policy_attachment" "sbp-attach2" {
  provider = aws.ident   
  group      = "${aws_iam_group.SBP-MemberAdmins.name}"
  policy_arn = "arn:aws:iam::aws:policy/IAMSelfManageServiceSpecificCredentials"
}

resource "aws_iam_group_policy_attachment" "sbp-attach3" {
  provider = aws.ident   
  group      = "${aws_iam_group.SBP-MemberAdmins.name}"
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "sbp-attach4" {
  provider = aws.ident   
  group      = "${aws_iam_group.SBP-MemberAdmins.name}"
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}


resource "aws_iam_policy" "SRE-Admin-Policy" {
  provider    = aws.ident  
  name        = "SRE-Admin-Policy"
  description = "Policy attached to AssumeRole for SRE admins."

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}



resource "aws_iam_role" "SAIC-SRE-Identity-Admin-Role" {
  provider = aws.ident  
  name = "SAIC-SRE-Admin-Role"
  assume_role_policy = "${data.aws_iam_policy_document.sre-assume-role-policy-identity.json}"

  tags = {
    Application          = "value1"
    Business_Service     = "value2"
    Business_Unit        = "value1"
    Change_Request       = "value2"
    Department           = "value1"
    Enclave              = "value2"
    Name                 = "value1"
    Project              = "value1"
    User                 = "value2"
    User_Group           = "value1"
    Terraform_Enterprise = "value2"
       }
}

resource "aws_iam_role" "SAIC-SRE-Identity-Audit-Role" {
  provider = aws.ident  
  name = "SAIC-SRE-Audit-Role"
  assume_role_policy = "${data.aws_iam_policy_document.sre-assume-role-policy-identity.json}"

  tags = {
    Application          = "value1"
    Business_Service     = "value2"
    Business_Unit        = "value1"
    Change_Request       = "value2"
    Department           = "value1"
    Enclave              = "value2"
    Name                 = "value1"
    Project              = "value1"
    User                 = "value2"
    User_Group           = "value1"
    Terraform_Enterprise = "value2"
       }
}

resource "aws_iam_role" "SAIC-SBP-Identity-SecurityAudit-Role" {
  provider = aws.ident  
  name = "SAIC-SBP-SecurityAudit-Role"
  assume_role_policy = "${data.aws_iam_policy_document.sbp-assume-role-policy-identity.json}"

  tags = {
    Application          = "value1"
    Business_Service     = "value2"
    Business_Unit        = "value1"
    Change_Request       = "value2"
    Department           = "value1"
    Enclave              = "value2"
    Name                 = "value1"
    Project              = "value1"
    User                 = "value2"
    User_Group           = "value1"
    Terraform_Enterprise = "value2"
       }
}


resource "aws_iam_role_policy_attachment" "SRE-Admin-Role-Attach-Identity" {
  provider   = aws.ident  
  role       = aws_iam_role.SAIC-SRE-Identity-Admin-Role.name
  policy_arn = aws_iam_policy.SRE-Admin-Policy.arn
}

resource "aws_iam_role_policy_attachment" "SRE-Audit-Role-Attach-Identity" {
  provider   = aws.ident   
  role       = aws_iam_role.SAIC-SRE-Identity-Audit-Role.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource "aws_iam_role_policy_attachment" "SRE-View-Role-Attach-Identity" {
  provider   = aws.ident   
  role       = aws_iam_role.SAIC-SRE-Identity-Audit-Role.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "SBP-Audit-Role-Attach-Identity" {
  provider   = aws.ident   
  role       = aws_iam_role.SAIC-SBP-Identity-SecurityAudit-Role.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource "aws_iam_role_policy_attachment" "SBP-View-Role-Attach-Identity" {
  provider   = aws.ident   
  role       = aws_iam_role.SAIC-SBP-Identity-SecurityAudit-Role.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}




data "aws_iam_policy_document" "sbp-assume-role-policy-identity" {
  provider = aws.ident  
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["${var.identity_id}"]
    }
  }
}

data "aws_iam_policy_document" "sre-assume-role-policy-identity" {
  provider = aws.ident  
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["${var.identity_id}"]
    }
  }
}


############################################Shared IAM Resources###########################################################

resource "aws_iam_policy" "SBP-Policy-Shared" {
  provider    = aws.shared  
  name        = "SBP-Assume-Policy-Shared"
  description = "AssumeRole for SBP users."

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1582757741877",
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582757794804",
            "Action": "health:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582757864381",
            "Action": "elasticloadbalancing:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582757941520",
            "Action": "cloudwatch:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582757960682",
            "Action": "rds:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582757988629",
            "Action": "aws-portal:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758010092",
            "Action": "eks:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758024831",
            "Action": "support:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758037927",
            "Action": "trustedadvisor:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758053499",
            "Action": "route53:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758064456",
            "Action": "autoscaling:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758078957",
            "Action": "elasticbeanstalk:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758095269",
            "Action": "s3:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758105125",
            "Action": "acm:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758129856",
            "Action": "application-autoscaling:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758146764",
            "Action": "dynamodb:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758162044",
            "Action": "kms:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758183484",
            "Action": "secretsmanager:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758198192",
            "Action": "sts:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758217706",
            "Action": "ses:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758231347",
            "Action": "lambda:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758241860",
            "Action": "cloudtrail:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758251689",
            "Action": "budgets:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758273472",
            "Action": "sns:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758290644",
            "Action": "ecr:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758303475",
            "Action": "sso:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758323359",
            "Action": "ecs:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758334391",
            "Action": "logs:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758349921",
            "Action": "cloudformation:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758364122",
            "Action": "elasticfilesystem:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1582758376827",
            "Action": "route53domains:*",
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}


resource "aws_iam_policy" "SRE-Policy-Shared" {
  provider    = aws.shared  
  name        = "SRE-Assume-Policy-Shared"
  description = "AssumeRole for SRE admins."

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}


data "aws_iam_policy_document" "sbp-assume-role-policy-shared" {
  provider = aws.shared  
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["${var.identity_id}"]
    }
  }
}

data "aws_iam_policy_document" "sre-assume-role-policy-shared" {
  provider = aws.shared  
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["${var.identity_id}"]
    }
  }
}


resource "aws_iam_role" "SBP-Assume-Role-Shared" {
  provider = aws.shared  
  name = "SBP-Assume-Role-Shared"
  assume_role_policy = "${data.aws_iam_policy_document.sbp-assume-role-policy-shared.json}"

  tags = {
    Application          = "value1"
    Business_Service     = "value2"
    Business_Unit        = "value1"
    Change_Request       = "value2"
    Department           = "value1"
    Enclave              = "value2"
    Name                 = "value1"
    Project              = "value1"
    User                 = "value2"
    User_Group           = "value1"
    Terraform_Enterprise = "value2"
       }
}


resource "aws_iam_role" "SRE-Assume-Role-Shared" {
  provider = aws.shared  
  name = "SRE-Assume-Role-Shared"
  assume_role_policy = "${data.aws_iam_policy_document.sre-assume-role-policy-shared.json}"

  tags = {
    Application          = "value1"
    Business_Service     = "value2"
    Business_Unit        = "value1"
    Change_Request       = "value2"
    Department           = "value1"
    Enclave              = "value2"
    Name                 = "value1"
    Project              = "value1"
    User                 = "value2"
    User_Group           = "value1"
    Terraform_Enterprise = "value2"
       }
}


resource "aws_iam_role_policy_attachment" "SBP-Assume-Role-Attach-Shared" {
  provider   = aws.shared  
  role       = aws_iam_role.SBP-Assume-Role-Shared.name
  policy_arn = aws_iam_policy.SBP-Policy-Shared.arn
}

resource "aws_iam_role_policy_attachment" "SRE-Assume-Role-Attach-Shared" {
  provider   = aws.shared   
  role       = aws_iam_role.SRE-Assume-Role-Shared.name
  policy_arn = aws_iam_policy.SRE-Policy-Shared.arn
}



############################################Security IAM Resources###########################################################

resource "aws_iam_policy" "SRE-Security-Admin-Policy" {
  provider    = aws.sec  
  name        = "SRE-Admin-Policy"
  description = "Policy attached to AssumeRole for SRE admins."

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}



resource "aws_iam_role" "SAIC-SRE-Security-Admin-Role" {
  provider = aws.sec  
  name = "SAIC-SRE-Admin-Role"
  assume_role_policy = "${data.aws_iam_policy_document.sre-assume-role-policy-security.json}"

  tags = {
    Application          = "value1"
    Business_Service     = "value2"
    Business_Unit        = "value1"
    Change_Request       = "value2"
    Department           = "value1"
    Enclave              = "value2"
    Name                 = "value1"
    Project              = "value1"
    User                 = "value2"
    User_Group           = "value1"
    Terraform_Enterprise = "value2"
       }
}

resource "aws_iam_role" "SAIC-SRE-Security-Audit-Role" {
  provider = aws.sec  
  name = "SAIC-SRE-Audit-Role"
  assume_role_policy = "${data.aws_iam_policy_document.sre-assume-role-policy-security.json}"

  tags = {
    Application          = "value1"
    Business_Service     = "value2"
    Business_Unit        = "value1"
    Change_Request       = "value2"
    Department           = "value1"
    Enclave              = "value2"
    Name                 = "value1"
    Project              = "value1"
    User                 = "value2"
    User_Group           = "value1"
    Terraform_Enterprise = "value2"
       }
}


resource "aws_iam_role_policy_attachment" "SRE-Admin-Role-Attach-Security" {
  provider   = aws.sec  
  role       = aws_iam_role.SAIC-SRE-Security-Admin-Role.name
  policy_arn = aws_iam_policy.SRE-Security-Admin-Policy.arn
}

resource "aws_iam_role_policy_attachment" "SRE-Audit-Role-Attach-Security" {
  provider   = aws.sec   
  role       = aws_iam_role.SAIC-SRE-Security-Audit-Role.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource "aws_iam_role_policy_attachment" "SRE-View-Role-Attach-Security" {
  provider   = aws.sec   
  role       = aws_iam_role.SAIC-SRE-Security-Audit-Role.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

data "aws_iam_policy_document" "sre-assume-role-policy-security" {
  provider = aws.sec  
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["${var.identity_id}"]
    }
  }
}




############################################Logging IAM Resources###########################################################


resource "aws_iam_policy" "SRE-Logging-Admin-Policy" {
  provider    = aws.log  
  name        = "SRE-Admin-Policy"
  description = "Policy attached to AssumeRole for SRE admins."

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}



resource "aws_iam_role" "SAIC-SRE-Logging-Admin-Role" {
  provider = aws.log  
  name = "SAIC-SRE-Admin-Role"
  assume_role_policy = "${data.aws_iam_policy_document.sre-assume-role-policy-logging.json}"

  tags = {
    Application          = "value1"
    Business_Service     = "value2"
    Business_Unit        = "value1"
    Change_Request       = "value2"
    Department           = "value1"
    Enclave              = "value2"
    Name                 = "value1"
    Project              = "value1"
    User                 = "value2"
    User_Group           = "value1"
    Terraform_Enterprise = "value2"
       }
}

resource "aws_iam_role" "SAIC-SRE-Logging-Audit-Role" {
  provider = aws.log  
  name = "SAIC-SRE-Audit-Role"
  assume_role_policy = "${data.aws_iam_policy_document.sre-assume-role-policy-logging.json}"

  tags = {
    Application          = "value1"
    Business_Service     = "value2"
    Business_Unit        = "value1"
    Change_Request       = "value2"
    Department           = "value1"
    Enclave              = "value2"
    Name                 = "value1"
    Project              = "value1"
    User                 = "value2"
    User_Group           = "value1"
    Terraform_Enterprise = "value2"
       }
}


resource "aws_iam_role_policy_attachment" "SRE-Admin-Role-Attach-Logging" {
  provider   = aws.log  
  role       = aws_iam_role.SAIC-SRE-Logging-Admin-Role.name
  policy_arn = aws_iam_policy.SRE-Logging-Admin-Policy.arn
}

resource "aws_iam_role_policy_attachment" "SRE-Audit-Role-Attach-Logging" {
  provider   = aws.log   
  role       = aws_iam_role.SAIC-SRE-Logging-Audit-Role.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource "aws_iam_role_policy_attachment" "SRE-View-Role-Attach-Logging" {
  provider   = aws.log   
  role       = aws_iam_role.SAIC-SRE-Logging-Audit-Role.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

data "aws_iam_policy_document" "sre-assume-role-policy-logging" {
  provider = aws.log  
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["${var.identity_id}"]
    }
  }
}
