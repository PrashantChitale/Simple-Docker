terraform {
  backend "s3" {
    bucket = "eks-loki-logs-prod-712394252404"
    key = "tf.state"
    region = "ap-south-1"
    profile = "terraform"
  }
}