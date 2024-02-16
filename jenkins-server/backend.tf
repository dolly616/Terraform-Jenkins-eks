terraform {
  backend "s3" {
    bucket = "eks-project-bucket1"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}