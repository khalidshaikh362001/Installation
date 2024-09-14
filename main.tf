# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  # Specify your AWS region
}

# Use Existing Key Pair
variable "existing_key_pair" {
  default = "projectkey"  # Replace with your existing key pair name
}

# Use Existing Security Groups
variable "master_sg" {
  default = "sg-06ba5ebc24f1f3aaf"  # Replace with your existing Security Group 1 ID
}

variable "worker_sg" {
  default = "sg-0392229768fe43ff7"  # Replace with your existing Security Group 2 ID
}

# EC2 Instance 1
resource "aws_instance" "master" {
  ami                    = "ami-0e86e20dae9224db8"  # Ubuntu 20.04 AMI ID, change as per region
  instance_type          = "t2.medium"
  key_name               = var.existing_key_pair
  vpc_security_group_ids = [var.master_sg]  # Use vpc_security_group_ids instead of security_groups
  
  tags = {
    Name = "Master"
  }
}

# EC2 Instance 2
resource "aws_instance" "worker" {
  ami                    = "ami-0e86e20dae9224db8"  # Ubuntu 20.04 AMI ID, change as per region
  instance_type          = "t2.medium"
  key_name               = var.existing_key_pair
  vpc_security_group_ids = [var.worker_sg]  # Use vpc_security_group_ids instead of security_groups

  tags = {
    Name = "Worker"
  }
}

# Output the SSH commands along with Git clone commands
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
