provider "aws" {
    version = "~> 2.26"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.aws_region}"
    skip_credentials_validation = true
}