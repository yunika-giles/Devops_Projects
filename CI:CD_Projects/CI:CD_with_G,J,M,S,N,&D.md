# Deploying a Java-Based Application using CI/CD with GitHub, Jenkins, Maven, SonarQube, Nexus, and Docker
![CI/CD](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/CI%3ACD.gif)
## Project Outline
- Set up the Environment on two Ubuntu Ec2 instances 
- Install CI/CD tools in the Ubuntu instance 
- Set up `Git` and `GitHub`.
- Integrate CI/CD tools (GitHub, Maven, Sonarqube, nexus and docker) with Jenkins 
TODO: add more outlines

## Setting up the Environment on two Ubuntu EC2 instances using terraform 
To create your `infrastructure as code using terraform` click [Here](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Terraformproject.tf) to access and download the full template. Open the template using VS code and endeavour to edit `line 13 and 14` with your access key and your secret access key. Then edit `line 144 and 170` with your key pair. Deploy the Terraform template by using the instructions below:

Initialize Terraform by running:
```python
terraform init
```
Run `terraform plan` to generate an execution plan:
```python
terraform plan
```
Run `terraform apply` to create the infrastructure on AWS
```python
terraform apply
```
## Install CI/CD tools in the Ubuntu instance 
Partition the CI/CD tools in the two ubuntu instance as shown below:
 + **Instance one(Jenkins-Instance):** Jenkins, Maven, SonarQube, and Java.
 + **Instance two(Docker-instance):**  Nexus, and Docker for application deployment.
    
Click on each of the CI/CD tools to see the installation instructions:
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

## Integrating CI/CD tools (GitHub, Maven, Sonarqube, nexus and docker) with Jenkins 
### Setting up Jenkins
##
### Access Jenkins UI:

To access the Jenkins UI, open a web browser and type in the IP address of your instance followed by:8080 (e.g., http://54.91.107.144:8080). Replace 54.91.107.144 with the actual IP address of your server.

Unlock Jenkins by using the initial admin password found at:

```python
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
TODO:![jenkins login picture]()

Once Jenkins is unlocked, you will be presented with the option to install suggested plugins or to select specific plugins manually.
Click `Install suggested plugins` to automatically install a standard set of plugins, which is recommended for most users.

![jenkins]()
### Create Your Admin User:
After plugin installation, you will be prompted to create an admin user for Jenkins.Fill out the form with the username, password, full name, and email address. Click `Save and Continue`
![jenkins admin]()

Jenkins will ask you to configure the URL for your Jenkins instance.
The default URL (based on your server’s IP and port) will be filled in. Click `Start using Jenkins` to complete the setup and be taken to the Jenkins dashboard.
![jenkins]()

### Install Necessary Plugins:
In Jenkins navigate to _Manage Jenkins > Plugins_. Under _Plugins _ look for the TODO: `docker pipeline` and `sonarqube scanner` plugins install them and restart Jenkins if required.
![jenkins]()
![jenkins]()