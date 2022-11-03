# Define AWS Provider #######################################
# It automatically takes the credentials from
# "~/.aws/credentials" for profile "okta-elastic-dev"
provider "aws" {
  region                   = "us-east-2"
  profile                  = "okta-elastic-dev"
}

# Reference to this module to make it accessible to this environment
module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = var.cluster_name
  # commenting this parameter so it is the same bucket name in all environments
  # db_remote_state_bucket = var.db_remote_state_bucket
  db_remote_state_key    = var.db_remote_state_key

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}