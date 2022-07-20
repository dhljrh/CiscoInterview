# CiscoInterview
Code for my Cisco take home exam

This is Version 1 that I created in between meetings and taking about 3 Terraform courses to get the Syntax correct, I am hoping to improve it but it has been tested in a AWS sandbox from my home PC and it deploys correctly.  I used AWS CLI to establish the connection to my sandbox doing the following

[dhallett@DonsPC webserver]$ aws configure
AWS Access Key ID [****************DPES]:
AWS Secret Access Key [****************YmIo]:
Default region name [us-east-1]:
Default output format [None]:

Once that was done I was able to deploy terraform with no issues other than bad syntax to my repo, I created a S3 bucket for the static statefile and that code is in the statefile/main.tf directory in this repo.  I named the bucket dons-terraform-bucket and added encryption to it.

In the main.tf at the root of the directory the choices I made for this exercise was I created a t2.micro server on AWS with an Amazon image using a subnet that didn't have public access enabled.  I also created a ssh key so terraform could login and install and start the apache instances and display a quick little message.  I originally tested it out with a public IP address and then set it to use the private IP upon the next run to stay within the parameters of the exercise.

To fully document my steps after I had aws cli configured to connect up to my test subscription and had the terraform code in place I then ran the code to create the S3 bucket

[dhallett@DonsPC cisco-terraform-aws]$ pwd
/home/dhallett/cisco-terraform-aws
[dhallett@DonsPC cisco-terraform-aws]$ cd statefile
[dhallett@DonsPC statefile]$ terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v4.22.0

Terraform has been successfully initialized!

Once that was done I ran 
$terraform plan to see what it was changing then 
terraform apply to create the bucket

Once done I went to my main code and created the S3 bucket with the private network, configured my statefile to be located on the new dons-terraform-bucket in the directory terraform/terraform.tfstate.  Created a ssh key to login as the ec2-user and had it install httpd.  

Some of the trade offs I made was that I hard coded the Subnet as I set it to one that I had set to not allow public access, and I didnt create a variables file for the sake of time since this exercise is a one off approach and didn't need to have multiple variables.

I am going to try to update this a bit over the next couple of days as I just read about a function called user_data which may make the deployment of the web server a little quicker.  I also forgot to mention I created the ssh key named "ssh-key-don" via the AWS console.

Cheers

-Don

