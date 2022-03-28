# code-challenge
The repository is created to demonstrate the IaC code implementation

The repository contains the 3 directories:

  * `api`: contains the api source code
  * `docker`: contains the docker file
  * `iac`: contains the IaC files

## api directory
The api is developed using the python and flask frameworks. The directory contains the source code for the api.

  * `app.py`: contains the api source code & api routes.
  * `requirements.txt`: contains the python dependencies.
  * `version.txt`: contains the version of the api

## docker directory
The docker directory contains the docker file.

  * `Dockerfile` : contains the docker file.

### Deploy the docker image 
**Step 1**: Build the image.
  ```
  docker build -t cc-uat:latest .
  ```
The above command will create a image with tag `cc-uat:latest`

**Step 2**: Run the container.
  ```
  docker run -dit --rm -p 80:80 --name cc-uat cc-uat:latest
  ```
The above command will run the container.


**Step 3**: SSH to container with below command
  ```
  docker exec -it cc-uat /bin/sh
  ```

**Step 4**: Test the container
Run the below command to test the container and up and running and api is returning the correct output.
  ```
  curl -i http://localhost
  ```

## IaC directory
The IaC code will create 
* New VPC containing 2 public subnets and 2 private subnets. 
* Elastic Container Service will be used for container orchestration.
* The container will be deployed in private subnets.
* The Elastic Load Balancer will be used to route traffic to containers.

The IaC code file structure is as follows.

  * `cc-uat.tfvars`: contains the IaC variables.
  * `main.tf`: main terraform file.
  * `Makefile`: contains the terraform commands.
  * `provider.tf`: contains the Cloud provider information.
  * `variables.tf`: contains the variables for the terraform.
  * `version.tf`: contains the version of the terraform and cloud provider.
  * `modules`: contains the terraform modules.
    * `alb`: contains the AWS Elastic Load Balancer module.
    * `dns`: contains the AWS Route 53 module.
    * `ecs`: contains the AWS ECS module.
    * `logs`: contains the AWS CloudWatch Logs module.
    * `roles`: contains the AWS IAM roles module.
    * `security_groups`: contains the AWS Security Group module.
    * `vpc`: contains the AWS VPC module.
    
Before deploying the IaC code, the following three variables need to be updated in `cc-uat.tfvars` file.
  * `profile`:  The AWS CLI configuration profile to use.
  * `region`: The AWS region to use.
  * `sub_domain`: The sub domain name for the container.
  * `zone_name`: The DNS zone name for the container.
  
Run the below command to deploy container and up and running and api is returning the correct output.
  ```
  cd /iac/ecs
  make plan
  make apply
  ```

Run below command to destory the container.
  ```
  cd /iac/ecs
  make destroy
  ```

## Things to do for Production 
  * To apply the SSL certificate in production environment follow belows steps.
  * Redirect HTTP Traffic to HTTPS Listener: In the `/iac/ecs/modules/alb/alb.tf` file, comment the lines from 39 to 48.
  * HTTPS Listener: In the `/iac/ecs/modules/alb/alb.tf` file, uncomment the lines from 51 to 78.