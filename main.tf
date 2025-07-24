# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  # Specify your AWS region
}

# Use Existing Key Pair
variable "existing_key_pair" {
  default = "awskey"  # Replace with your existing key pair name
}

# Use Existing Security Groups
variable "master_sg" {
  default = "sg-0ce011ede09d1ff90"  # Replace with your existing Security Group 1 ID
}

variable "worker_sg" {
  default = "sg-076a6c455f3ed865e"  # Replace with your existing Security Group 2 ID
}

#Variables for Existing IAM Roles
variable "master_iam_role" {
  default = "MasterNode"  # Replace with your MasterNode role name
}

variable "worker_iam_role" {
  default = "Workernode"  # Replace with your WorkerNode role name
}

variable "jenkins_sg" {
  default = "sg-034bc276df0eda901"  # Replace with your existing Security Group 2 ID
}

variable "default" {
  default = "sg-089a5c67d8d9ce49b"  # Replace with your existing Security Group 2 ID
}



# EC2 Instance 1
resource "aws_instance" "master" {
  ami                    = "ami-0e2c8caa4b6378d8c"  # Ubuntu 20.04 AMI ID, change as per region
  instance_type          = "t2.medium"
  key_name               = var.existing_key_pair
  vpc_security_group_ids = [var.master_sg]  # Use vpc_security_group_ids instead of security_groups
  
  
  # iam_instance_profile = aws_iam_instance_profile.master_instance_profile.name

  root_block_device {
    volume_size = 30  # Set the root volume size to 30 GB
  }


  tags = {
    Name = "Master"
    "kubernetes.io/cluster/kubernetes" = "owned"
  }
}

# EC2 Instance 2
resource "aws_instance" "worker" {
  ami                    = "ami-0e2c8caa4b6378d8c"  # Ubuntu 20.04 AMI ID, change as per region
  instance_type          = "t2.medium"
  key_name               = var.existing_key_pair
  vpc_security_group_ids = [var.worker_sg]  # Use vpc_security_group_ids instead of security_groups

  # iam_instance_profile = aws_iam_instance_profile.worker_instance_profile.name

  root_block_device {
    volume_size = 30  # Set the root volume size to 30 GB
  }

  tags = {
    Name = "Worker"
    "kubernetes.io/cluster/kubernetes" = "owned"
  }
}

# #EC2 Instance 3
# resource "aws_instance" "jenkins" {
#   ami                    = "ami-0e2c8caa4b6378d8c"  # Ubuntu 20.04 AMI ID, change as per region
#   instance_type          = "t2.medium"
#   key_name               = var.existing_key_pair
#   vpc_security_group_ids = [var.jenkins_sg]  # Use vpc_security_group_ids instead of security_groups

#   tags = {
#     Name = "Jenkins"
#   }
# }

# # EC2 Instance 4
# resource "aws_instance" "sonarqube" {
#   ami                    = "ami-0e2c8caa4b6378d8c"  # Ubuntu 20.04 AMI ID, change as per region
#   instance_type          = "t2.medium"
#   key_name               = var.existing_key_pair
#   vpc_security_group_ids = [var.default]  # Use vpc_security_group_ids instead of security_groups

#   tags = {
#     Name = "Sonarqube"
#   }
# }

#EC2 Instance 5
# resource "aws_instance" "nexus" {
#   ami                    = "ami-0e2c8caa4b6378d8c"  # Ubuntu 20.04 AMI ID, change as per region
#   instance_type          = "t2.medium"
#   key_name               = var.existing_key_pair
#   vpc_security_group_ids = [var.default]  # Use vpc_security_group_ids instead of security_groups

#   tags = {
#     Name = "Nexus"
#   }
# }


#Output the SSH commands along with Git clone commands
output "master_public_ip" {
value = <<-EOF
            ssh -i "${var.existing_key_pair}.pem" ubuntu@${aws_instance.master.public_ip} 
            git clone https://github.com/khalidshaikh362001/Installation.git ; chmod -R 777 Installation ; cd Installation
          EOF
}

output "worker_public_ip" {
 value = <<-EOF
            ssh -i "${var.existing_key_pair}.pem" ubuntu@${aws_instance.worker.public_ip}
            git clone https://github.com/khalidshaikh362001/Installation.git ; chmod -R 777 Installation ; cd Installation
          EOF
}

# output "jenkins_public_ip" {
#  value = <<-EOF
#             ssh -i "${var.existing_key_pair}.pem" ubuntu@${aws_instance.jenkins.public_ip}
#             git clone https://github.com/khalidshaikh362001/Installation.git ; chmod -R 777 Installation ; cd Installation
#           EOF
# }

# output "sonarqube_public_ip" {
#  value = <<-EOF
#             ssh -i "${var.existing_key_pair}.pem" ubuntu@${aws_instance.sonarqube.public_ip}
#             git clone https://github.com/khalidshaikh362001/Installation.git ; chmod -R 777 Installation ; cd Installation
#           EOF
# }

# output "nexus_public_ip" {
#  value = <<-EOF
#             ssh -i "${var.existing_key_pair}.pem" ubuntu@${aws_instance.nexus.public_ip}
#             git clone https://github.com/khalidshaikh362001/Installation.git ; chmod -R 777 Installation ; cd Installation
#           EOF
# }
