
# Aws Instance creation

For this Project aws account is created and attached the volumes by using terraform 
and installed apache2 server

## Acknowledgements

 - [Requried modules](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest)
 - [Aws ec2_instance](https://github.com/akhilpe/Terraform_Assignment_3.git)
 - [Volume provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume)
 - [http provider](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http)


## Contributing


See `terraform.io` for ways to get started.

Please adhere to this project's `https://github.com/akhilpe/Terraform_assignment_4.git`

## Deployment

terraform init

```terraform commands
  terraform validate
  terraform refresh
  terraform plan
  terraform apply
  terraform destroy
```


## Features

- Create aws instance
- Create aws volume
- Attached the volume to the instance
- Placed apache2 server and start the service


## Appendix

Place the Access_key and Secret_key by using IAM policies
and  then it created aws instance and volumes and then volume going to attach the same instance.
Installed apache2 server and started the service 
and their is a destory.tf file where to uninstall 
apache2 service first and then it destroy instance
