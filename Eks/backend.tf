terraform {
  backend "s3" {
    bucket = "eks-project-bucket1"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}