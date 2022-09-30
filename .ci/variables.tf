variable "stage" {
    description = "stage for deploy application PROD | HML"
    type = string
}

variable "region"{
    description = "region in aws cloud to deploy"
    type = string
}

variable "keypair" {
    description = "name of keypair to deploy in aws cloud, you must create before execute plan"
    type = string
}

variable "vpc_id"{
    description = "vpc_id to deploy application"
    type = string
}