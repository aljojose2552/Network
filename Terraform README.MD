Install Terraform
install AWS CLI
created main.tf file- defining the resources EC2 instance, subnet, VPC, configures security group rules for controlling inbound and outbound traffic. Specifies outputs for key information such as instance public IP addresses or VPC IDs.
# code powershell
Terraform init
terraform validate
terraform plan
terraform apply


# Troubleshooting
we have choosen region eu-west-1, so wee need to change our ami, since AMI IDs are region-specific.
we have Choosen an AMI ID specific to our region  and modify them main.tf with this ID. Then re-run terraform plan and terraform apply again.
