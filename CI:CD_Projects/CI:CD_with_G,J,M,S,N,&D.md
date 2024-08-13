# Deploying a Java-Based Application using CI/CD with GitHub, Jenkins, Maven, SonarQube, Nexus, and Docker
![CI/CD](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/CI%3ACD.gif)
## Project Outline
- Set up `Git` and `GitHub`.
- Set up the Environment on two Ubuntu Ec2 instances using terraform
- Install CI/CD tools in the Ubuntu instance 
- Integrate CI/CD tools (GitHub, Maven, Sonarqube, nexus and docker) with Jenkins 
TODO: add more outlines

## Setting up Git and Github
**Install Git**
To install git, see [git install](https://git-scm.com/downloads) 

**Configure git:**
```python
git config --global user.name "your-full-names"
```
```python
git config --global user.email "gitHubEmail"
```
Make sure to replace the username and email with your username and email.

**Create an account with github: To create an account in github, see [GitHub Account](https://github.com)**

Open your terminal, navigate to the directory where you want to clone the repository. Clone the project from `GitHub` by running this command:

```python
git clone https://github.com/yunika-giles/init-app.git
```

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
 + **Instance one(Jenkins-Instance):** Jenkins, Maven, SonarQube, and Java,.
 + **Instance two(Docker-instance):**  Nexus, and Docker for application deployment.
    
Click on each of the CI/CD tools to see the installation instructions:
- [Jenkins](https://github.com/yunika-giles/Giles-Workspace/blob/main/bash_scripts/jenkins_install.md) 
- [Apache Maven](https://github.com/yunika-giles/Giles-Workspace/blob/main/bash_scripts/maven_install.md)
- [SonarQube](https://github.com/yunika-giles/Giles-Workspace/blob/main/bash_scripts/sonarqube_install.md) 
- [Docker](https://github.com/yunika-giles/Giles-Workspace/blob/main/bash_scripts/docker_install.md) 
- [Sonartype Nexus](https://github.com/yunika-giles/Giles-Workspace/blob/main/server_installation/Nexus_installation.md) 
  


## Integrating CI/CD tools (GitHub, Maven, Sonarqube, nexus and docker) with Jenkins 
### Setting up Jenkins
##
### Access Jenkins UI:

To access the Jenkins UI, open a web browser and type in the IP address of your instance followed by:8080 (e.g., http://54.91.107.144:8080). Replace 54.91.107.144 with the actual IP address of your server.

Unlock Jenkins by using the initial admin password found at:

```python
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

![jenkins login picture](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/SCR-20240803-jllw.png)

Once Jenkins is unlocked, you will be presented with the option to install suggested plugins or to select specific plugins manually.
Click `Install suggested plugins` to automatically install a standard set of plugins, which is recommended for most users.

![jenkins](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/jenk.png)
![jenkins](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/jenki.png)

### Create Your Admin User:
After plugin installation, you will be prompted to create an admin user for Jenkins.Fill out the form with the username, password, full name, and email address. Click `Save and Continue`

![jenkins admin](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/jenkins.png)

Jenkins will ask you to configure the URL for your Jenkins instance.
The default URL (based on your server’s IP and port) will be filled in. Click `Start using Jenkins` to complete the setup and be taken to the Jenkins dashboard.

![jenkins](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/jenkins1.png)

### Install Necessary Plugins:
In Jenkins navigate to _Manage Jenkins > Plugins_. Under _Plugins _ look for the `sonarQube scanner`, and ` Nexus Artifact Uploader`plugins install them and restart Jenkins if required.

![jenkins](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/jenkins2.png)
![jenkins](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/jenkins3.png)

## Jenkins GitHub Integrations
In Jenkins navigate to `Dashboard` and create a new project `(+ New Item)`.
![git-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/git-jen.png)

Enter the desired project name and select `Freestyle project`. Then, click `OK`.

![git-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/git-jen1.png)

In the project configuration page, check the `GitHub project` box. In the Project URL field, paste your `GitHub project URL`

![git-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/git-jen0.png)

Under  `Source Code Management` section. 
- Select `Git` 
- Copy your `GitHub repository URL` and paste it into the `Repository URL` field.
- Under `Credentials`, select `+Add` then `Jenkins`
![git-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/git-jenkins2.png)

In the `Jenkins Credentials Provider` page, fill in the credentials as follows:
- Leave `Domain`, `Kind` and `Scope` as default.
- Under `username`, input your `jenkins username` and `password`.
- Under `ID`, input your `identifier`.
- Input your description and select `Add`.
  
![git-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/git-jen3.png)

Now Under `Credentials` replace `-none-` with your credentials.

![git-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/git-jen4.png)

Under `Branches to build` input the branch you want to build from. then click on the `save` button.

![git-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/git-jen5.png)

Select `Build Now`.
![git-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/git-jen6.png)
## Jenkins Maven Integrations
In Jenkins, navigate to the `Dashboard`, select `Manage Jenkins`, and then click on `Tools`. Scroll down to the `Maven` section and click the `Add Maven` button. 
![mav-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/mav-jen.png)


In Jenkins, go to the `Dashboard`, select your project (e.g., `init-app`), and then click on `Configure`. In the project configuration page, click on `Build Steps`. Under `Build Steps`, click on `Add build step` and select `Invoke top-level Maven targets`. In the `Maven Version` dropdown, select the Maven version you added in the previous step. In the `Goals` field, enter the Maven goals you want to execute (e.g., `clean package`). Click `Save` to save your changes. then click on `Build Now`.
![mav-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/maven-jen1.png)