variable "jenkins_vpc" {
    description = "This is the CIDR block for my VPC"
    default        = "10.0.0.0/16"
}

variable "public-sub-1" {
    description = "This is the CIDR block for my subnet"
    default        = "10.0.1.0/24"
}

variable "public-sub-2" {
    description = "This is the CIDR block for my subnet"
    default        = "10.0.2.0/24"
}

variable "private-sub-1" {
    description = "This is the CIDR block for my subnet"
    default        = "10.0.101.0/24"
}

variable "private-sub-2" {
    description = "This is the CIDR block for my subnet"
    default        = "10.0.102.0/24"
}

variable "availability-zone" {
    description = "Availability zone for the subnet"
    default        = "ap-south-1a"
}

variable "availability-zone1" {
    description = "Availability zone for the subnet"
    default        = "ap-south-1b"
}

variable "cidr_all" {
    description = "CIDR block allowed for all"
    default        = "0.0.0.0/0"
}
