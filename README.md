# labos-assignment

## Requirements 
1. Write a python program that will listen on port 8080 and accept incoming API requests:<br><br>
  a. It should receive requests with a URL path, which in practice represents the GitHub user, followed by a GitHub repository. (e.g for https://github.com/elastic/elasticsearch you will use localhost:8080/elastic/elasticsearch)<br>
  b. Your program will implement a REST endpoint which in turn will utilize GitHub’s API to get the version of the last release of that repository, and send it as a response to the calling client.<br><br>
2. Install an nginx server and write an nginx config file that will listen on port 80 and forward traffic to your Python program.<br>
3. Create a dockerfile for each program one sections 1 and 2.<br>
*Make sure you can access your Python container from the Nginx container.<br>
4. Write a Terraform script to create the infrastructure with all of the resources you need (i.e vpc, subnets, security groups, etc) and the service you wrote. The goal is to be able to connect to this service from anywhere via port 80 to reach your program.(you can use ec2 user data or any other way)<br>
*Please tag any resource you create with your name<br>
5. Now you should be able to access the server using its IP address, run your docker containers and query the latest version of a GitHub repository.<br>


## How to run and check
1. Upload the repo to a computer with Terraform installed.<br>
2. Connect to the AWS account with the `AWS Access ID`, `AWS Secret Key` and the relevant `AWS_Region`
3. Go to the `terraform` folder on the Repo code.
4. Run `terraform init`
5. Run `terraform paln` (in order to check the Resource that will be created) and verify all look ok.
![image](https://user-images.githubusercontent.com/64369709/226870267-4bf9b217-10a2-49fc-9602-38fde15b6656.png)

6. Run `terraform apply`
![image](https://user-images.githubusercontent.com/64369709/226870513-d13824e8-a072-43de-92d2-dd33b1c74b9b.png)
7. Verify all the Resource were created:
![image](https://user-images.githubusercontent.com/64369709/226871080-d40b09db-32e2-4991-9930-eeccfab28019.png)
8. Check the code response with the EC2 server's IP on the browser: 

![image](https://user-images.githubusercontent.com/64369709/226871639-ed5da5c5-c0ef-42e0-87a9-6399afd19f14.png)<br><br><br>
![image](https://user-images.githubusercontent.com/64369709/226871745-789ca6b5-3ed1-440c-9a07-0144217d07f8.png)
