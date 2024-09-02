# Deploying a Java-Based Application using CI/CD with GitHub, Jenkins, Maven, SonarQube, Nexus, and Docker
![CI/CD](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/CI%3ACD.gif)
## Project Outline
- Set up `Git` and `GitHub`.
- Set up the infrastructure using Terraform on two Ubuntu EC2 instances 
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

## Setting up the infrastructure using Terraform on two Ubuntu EC2 instances 
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
- [Sonartype Nexus](https://github.com/yunika-giles/Giles-Workspace/blob/main/bash_scripts/nexus_installation.md) 
  


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
In Jenkins navigate to _Manage Jenkins > Plugins_. Under _Plugins _ Click on `available plugins` look for the `sonarQube scanner`, and ` Nexus Artifact Uploader`plugins install them and restart Jenkins if required.

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
In Jenkins, navigate to the `Dashboard`, select `Manage Jenkins`, and then click on `Tools`. Scroll down to the `Maven` section and click the `Add Maven` button. Fill in the `Name` select the latest version of maven and then click the `save` button

![mav-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/mav-jen.png)


In Jenkins, go to the `Dashboard`, select your project (e.g., `init-app`), and then click on `Configure`. In the project configuration page, click on `Build Steps`. Under `Build Steps`, click on `Add build step` and select `Invoke top-level Maven targets`. In the `Maven Version` dropdown, select the Maven version you added in the previous step. In the `Goals` field, enter the Maven goals you want to execute (e.g., `clean package`). Click `Save` to save your changes. 

![mav-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/maven-jen1.png)

Then click on `Build Now`.
## Jenkins SonarQube Integrations (Code Quality) 
Access SonarQube by entering `http://<your_instance_ip>:9000` in your browser, replacing `<your_instance_ip>` with your server's IP address.The default login credentials for SonarQube are:
- Username: `admin`
- Password: `admin`
However, it’s recommended to change these default credentials after the initial setup for security reasons.

![son-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/Son-jen.png)
In SonarQube, generate a token by following these steps:
- Go to `Administration` > `Security` > `Users`
- Click on `Token`
- Enter a token name and select a `duration`
- Click `Generate`
- `Copy` Token and Backup for you won't be able to see or copy it again.
  
![son-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/son-jen1.png)
![son-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/son-jen2.png)
![son-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/son-jen3.png)

In your project's code repository in GitHub, navigate to the build script (pom.xml) and locate the `<properties>` tag. Add or edit the following properties within this tag:

![son-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/son-jen4.png)

After making changes `save` and Commit the changes.

**Configure SonarQube in Jenkins by following these steps:**

- Navigate to `Dashboard` > `Manage Jenkins` > `System`.
- Scroll down to `SonarQube Servers` and click `Add SonarQube`.
- Check `Environmental Variables` box and input the following:
    + Name: [your-name]
    + Server URL: [your-server-URL, e.g.,` http://<InstanceIP>:9000`]
- Server authentication token: Create a new token by clicking the `+Add` button below.
    + Jenkins `Domain`: leave as default
    + `Kind`: Secret text
    + `Scope`: leave as default
    + `Secret`: [your-sonarqube-token]
    + `ID`: [your-ID, e.g., jenkins-sonar-cred]
    + `Description`: [your-Description, e.g., jenkins-sonar-cred]   
- Click `Add`,

![son-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/sonar-jen5.png)
![son-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/sonar-jen6.png)
![son-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/sonar-jen7.png)
  
- Select what you just created and then `Save`.

![son-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/sonar-jen8.png)

**Next, configure your project to run SonarQube analysis:**

- Go to `Dashboard` > `yourProject` > `Configure`.
- In the Build Steps section, click `Add Build Step` and select `Invoke-top-level Maven Targets`.
- Under `Maven Version`, select your preconfigured Maven version.
- Under 'Goal', enter `sonar:sonar`.
- Click `Save` and then `Build Now` to run the job.
  
![son-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/sonar-%20jen9.png)
![son-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/sonar-jen10.png) 

## Jenkins Nexus Integrations (Artifact Backup) 
Access SonarQube by entering `http://<your_instance_ip>:8081` in your browser, replacing <your_instance_ip> with your server's IP address. The default login credentials for Nexus are:
- Username: `admin`
- Default password path: `/nexus-data/admin.password` you can obtain the admin password by executing the following command in the terminal where Docker is running:
```python
docker exec -it <container_name> cat /nexus-data/admin.password
```
Replace <container_name> with the actual name of your Nexus container. This command will display the admin password in the terminal.

![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nex-jen.png)

To configure Nexus, follow these steps: 

- Log in to Nexus and navigate to `Server Administration and Configuration` (represented by a gear icon).
- Click on `Repositories` and then `Create Repository`.
  
![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nex-jen1.png)
![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nex-jen1.0.png)
- Select `Maven2(hosted)` and fill in the details:
    - Name: [your-repository-name]
    - Version Policy: `Release`
    - Layout Policy: `Strict`
    - Content Disposition: `Inline`
    - Blob Store: `default`
    - Deployment Policy: `Allow Redeploy`
- Click Create Repository to save your changes.
  
![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nex-jen2.png)
- Repeat the process to create a second repository (e.g `init-app-snapshot`), using the same steps but with one change:
    - Version Policy: Snapshot (instead of Release)
- This will set up two separate repositories in Nexus, one for `releases` and one for `snapshots`.
  
![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nex-jen3.png)

To configure your pom.xml file in your github repository, follow these steps:

1. Open the pom.xml file in your github repository.
2. Locate the `<distributionManagement>` section.
3. Update the following elements:
    - `id`: Enter the repository name you created in Nexus, suffixed with "-snapshot".
    - `name`: Enter the same Nexus snapshot repository name.
    - `url`: Enter the URL of the snapshot repository.

![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nex-jen4.png)
![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nexus-jen5.png)
![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nex-jen6.png)

After making changes `save` and Commit the changes.

**Set up Jenkins for your project by following these steps:**

1. Access your project's configuration: `Project(init-app)` > `Configure` > `Build Steps`
2. Add a new build step: `Nexus Artifact Uploader`

![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nex-jen7.png)
1. Enter the Nexus details:
    - Version: NEXUS3
    - Protocol: HTTP
    - URL: your Nexus URL (without `http/https`, e.g., `<instanceIP>:8081`)
    - Credentials: use the credentials configured in Nexus for the `web application`
    - GroupId: your project name (e.g., `init-app`)
    - Version: your version number (e.g., `1.0-SNAPSHOT`)
    - Repository: select the repository created in Nexus (e.g., `init-app-snapshot`)

![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nex-jen8.png)
![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nex-jen9.png)
![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nex-jen10.png)

1. Add artifacts:
    - ArtifactId: your ID (subfolder inside your GroupId, e.g., `init-app-v1.0`)
    - Type: `war`
    - Classifier: leave blank
    - File: enter the complete path to your `.war file` on your backend. Default path could be found in: `/var/lib/jenkins/`(e.g., `/var/lib/jenkins/workspace/init-app/target/init-app.war`)
  
![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nex-jen11.png)
![nex-jen](https://github.com/yunika-giles/Devops_Projects/blob/main/CI%3ACD_Projects/Images/nex-jen12.png)

2. Save the changes and click `Build Now` to execute the build process.

## Jenkins Docker Integrations 
1. Go to the Dashboard and click on `+ New Item`.
2. Enter your job name, select `Pipeline`, and click `OK`.
3. In the `Configure` section, add a description under `General`.
4. Set the `Discard old builds` option and choose the maximum number of builds to keep.
5. Select `Pipeline` on the left panel, and under `Definition`, choose `Pipeline script`. 
6. Edit 
```python
pipeline {
    agent { 

    environment {
        GITHUB_REPO_URL = 'Paste your GitHub repo'
        BRANCH_NAME = 'main'  // Replace with your branch name if it's not 'main'
        GITHUB_CREDENTIALS_ID = 'Paste GitHub-token'  // Replace with your Jenkins GitHub credentials ID
        DOCKERHUB_CREDENTIALS_ID = 'dockerhub'  // Replace with your Jenkins Docker Hub credentials ID
        DOCKERHUB_REPO = 'Paste your Docker repo'  // Replace with your Docker Hub repository
    }

    stages {
        stage('Agent Details') {
            steps {
                echo "Running on agent: ${env.NODE_NAME}"
                sh 'uname -a'  // Print system information
                sh 'whoami'    // Print the current user
            }
        }

        stage('Clone Repository') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: "${env.GITHUB_REPO_URL}", credentialsId: "${env.GITHUB_CREDENTIALS_ID}"
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'  // Simple Maven build
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    sh 'docker --version'  // Verify Docker installation
                    sh "docker build -t ${env.DOCKERHUB_REPO}:latest ."  // Build Docker image
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "${env.DOCKERHUB_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                        sh "docker push ${env.DOCKERHUB_REPO}:latest"
                        sh 'docker logout'
                    }
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker run --name init-con --rm -d -p 8090:8080 ${env.DOCKERHUB_REPO}:latest"  // Run Docker container in detached mode
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Docker containers and images...'
            sh 'docker rm $(docker ps -a -q) || true'
            sh 'docker rmi $(docker images -q) || true'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
    }
}
```
7. Paste your script in the provided area, click `Save`, and then `Build Now`.
   