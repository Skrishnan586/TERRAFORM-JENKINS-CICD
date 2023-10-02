terraform {
  backend "s3" {
    bucket         = "skbucket2207"
    key            = "my-terraform-environment/main"
    region         = "ap-southeast-1"
    dynamodb_table = "mrcloudbook-dynamo-db-table"
  }
}
