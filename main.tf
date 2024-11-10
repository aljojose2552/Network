# Specify the provider with Access Key and Secret Key (not recommended for production)
provider "aws" {
  region     = "eu-west-1"                 # Set your preferred region
}

# Define the VPC
resource "aws_vpc" "project_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "ProjectVPC"
  }
}

# Define a public subnet
resource "aws_subnet" "project_subnet" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"  # Specify availability zone
  map_public_ip_on_launch = true  # Ensures instances get a public IP address
  tags = {
    Name = "ProjectSubnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "project_igw" {
  vpc_id = aws_vpc.project_vpc.id
  tags = {
    Name = "ProjectInternetGateway"
  }
}

# Create a Route Table
resource "aws_route_table" "project_route_table" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"  # Default route to internet
    gateway_id = aws_internet_gateway.project_igw.id
  }

  tags = {
    Name = "ExampleRouteTable"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "project_route_table_association" {
  subnet_id      = aws_subnet.project_subnet.id
  route_table_id = aws_route_table.project_route_table.id
}

# Define a Security Group
resource "aws_security_group" "project_sg" {
  vpc_id = aws_vpc.project_vpc.id
  description = "Allow SSH and HTTP traffic"

  # Ingress rule for SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows SSH access from anywhere (change for security)
  }

  # Ingress rule for HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows HTTP access from anywhere
  }

  # Egress rule (allow all outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ProjectSecurityGroup"
  }
}

# Define an EC2 instance
resource "aws_instance" "project" {
  ami             = "ami-0d64bb532e0502c46"   # ubuntu for eu-west-1 (check region for correct AMI)
  instance_type   = "t2.micro"                # Free-tier eligible instance type
  subnet_id       = aws_subnet.project_subnet.id
  security_groups = [aws_security_group.project_sg.id]  # Attach the security group
  key_name      = "key_pair"

  tags = {
    Name = "GroupProject"
  }
}

# Output the instance's public IP
output "instance_ip" {
  value = aws_instance.project.public_ip
}
