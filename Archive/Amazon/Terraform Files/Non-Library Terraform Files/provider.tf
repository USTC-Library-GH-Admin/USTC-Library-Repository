provider "aws" {
  region       = "us-east-1"
  alias        = "log"
  assume_role {
  role_arn     = "arn:aws:iam::${var.logging_id}:role/master_bootstrap_role"
  session_name = "terraform-cloud-session"
 }
}

provider "aws" {
  region       = "us-east-1"
  alias       = "ident"
  assume_role {
  role_arn     = "arn:aws:iam::${var.identity_id}:role/master_bootstrap_role"
  session_name = "terraform-cloud-session"
  }
 }

 provider "aws" {
  region       = "us-east-1"
  alias       = "sec"
  assume_role {
  role_arn     = "arn:aws:iam::${var.security_id}:role/master_bootstrap_role"
  session_name = "terraform-cloud-session"
  }
 }
 
 provider "aws" {
  region       = "us-east-1"
  alias       = "shared"
  assume_role {
  role_arn     = "arn:aws:iam::${var.shared_id}:role/master_bootstrap_role"
  session_name = "terraform-cloud-session"
  }
 }
