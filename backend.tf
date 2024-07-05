terraform {
  backend "s3" {
    bucket         = "static-host-terraform"
    key            = "my-terraform-environment/main"
    region         = "us-east-1"
    dynamodb_table = "harshakrithvik-dynamo-db-table"
  }
}
