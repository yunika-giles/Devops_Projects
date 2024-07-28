# Deploying a Java-Based Application using CI/CD with GitHub, Jenkins, Maven,SonarQube, Nexus, and Docker
![CI/CD](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/CI%3ACD.gif)
## Project Outline
- Set up the Environment on two Ubuntu Ec2 instances 
- Install CI/CD tools in the Ubuntu instance 
- Set up `Git` anf `GitHub`.
TODO: add more outlines

## Setting up the Environment on two Ubuntu EC2 instances
- Launch 2 Ubuntu instances and install the necessary tools and software as shown below:
  + **Instance one:** Jenkins, Maven, SonarQube, and Java.
  + **Instance two:**  Nexus, and Docker for application deployment.  

If you want to manually create your infrastructure follow the instructions below:
### Instance One
**Instance Configuration:** 
- Create a VPC, internet gateway, Route table, 2 subnets, and Security Groups.
   + Security Groups: Configure security groups to allow HTTP(80), SSH(22), Custom TCP (8080), Custom TCP (9000),Custom TCP (8081).
- See how to launch an Ubuntu EC2 Instance [Here](https://docs.aws.amazon.com/kinesisvideostreams/latest/dg/gs-ubuntu.html)
  + Amazon Machine Image (AMI): Ubuntu 24
  + instance type: select t2.medium 
  + Create a Key pair.
  + Network settings: select the VPC, subnet and security group you have created.
TODO: add more configuration
   
### Instance Two
**Instance Configuration:**
   + Amazon Machine Image (AMI): Ubuntu 22 
   + Instance type: select t2.medium
   + Create a Key pair.
TODO: add more configuration

If you want to create your infrastructure as code using terraform click [Here]() to access the full template. Endeavour to edit line TODO: with your secret access key and your access key. Then edit line  TODO: with your key pair. 

## Install CI/CD tools in the Ubuntu instance 
- [Jenkins](https://github.com/yunika-giles/Giles-Workspace/blob/main/server_installation/Jenkins-Installation.md#jenkins-standalone-installation) 
- [Apache Maven](https://github.com/yunika-giles/Giles-Workspace/blob/main/server_installation/Maven.md)
- [SonarQube](https://github.com/yunika-giles/Giles-Workspace/blob/main/server_installation/Sonarqube_installation.md) 
- [Sonartype Nexus](https://github.com/yunika-giles/Giles-Workspace/blob/main/server_installation/Nexus_installation.md) 
- [Docker](https://github.com/yunika-giles/Giles-Workspace/blob/main/bash_scripts/docker_install.md) 

## Setting up Git and Github
**Install Git**
To install git, see [git install](https://git-scm.com/downloads) 
**Configure git:**
```
git config --global user.name "your-full-names"
```
```
git config --global user.email "gitHubEmail"
```
Make sure to replace the username and email with your username and email.

**Create an account with github: To create an account in github, see [GitHub Account](https://github.com)**

