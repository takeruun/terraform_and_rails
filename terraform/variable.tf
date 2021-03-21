variable "aws_region" {
  default = "ap-northeast-1"
}

variable "aws_profile" {
  # type = string
  default     = "default"
  description = "AWS CLI's profile"
}

variable "app_name" {
  type    = string
  default = "rails_hello"
}

# variable "azs" {
#   type    = list(any)
#   default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
# }
# 
# variable "domain" {
#   type = string
# 
#   default = "t-farm.ml"
# }
