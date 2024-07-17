# DevOp Project: Deploy a Dynamic Website by running a docker container

## Project Outline 
- The Development and Production environment should be separated.
- In your production environment, run the container in a custom bridge network.
- Make sure your data is persisted.
- Use the a scanner like `trivy`, to scan your Images both in the `dev` and `prod environments`.
- Above all, make sure to use `docker images` and `container` `best practices` during this entire project.
  
## Download your Bootstrap Template
click [Here](https://bootstrapmade.com) to download your Bootstrap Template.

TODO: Add a link to the Bootstrap image
![Bootstrap Template]()
You can click on `live` to view the websites: 
TODO: Add a link to the Bootstrap image

![Bootstrap Template]()

When you are satisfied with your selection then download it by clicking on `Free Download`. 

## Github
Create a project repository on Github:

TODO: Add a link to the Bootstrap image.
![Bootstrap image]()
![Bootstrap image]()

Input your repository name, give it a description and then create the repository. 

## Git
- Create the project repository on your laptop
- Copy the Bootstrap folder to your project repo
- Open a terminal and cd to your project repo
  
Initialize the repository:
```
git init
```
Add your file to the `Staging Area` :
```
git add .
```
Commit to the `Production Area`
```
git commit -m "your commit message"
```
Add your GitHub repository to your local environment
```
git remote add origin your-project-url 
```
Rename the current branch to `main`
```
git branch -M main
```
Push to GitHub by setting up tracking between the `local main` branch and the `remote main` branch
```
git push -u origin main
```
## On the Cloud (AWS)
- Launch 2 ubuntu instances:
   + Dev Instance 
   + Prod Instance
- Install `docker` in both instances
- Install `trivy` in both instances
  
## Dev Instance
Become root:
```
sudo -i
```
**Update and upgrade your server**
```
apt update
```
```
apt upgrade -y
```
**Install Java as a Prerequisite**
```
apt install default-jre -y
```
**Install net-tools**
```
apt install net-tools
```
**Install Docker**
```
apt install default-jre -y
```
Change docker.sock permissions to be readable and writeable by all users:
```
chmod 666 /var/run/docker.sock
```
Enable Docker:
```
systemctl enable docker 
```
Start Docker:
```
systemctl start docker
```
Check Docker status:
```
systemctl status docker
```
**Install Trivy**
Install trivy:
```
wget https://github.com/aquasecurity/trivy/releases/download/v0.21.0/trivy_0.21.0_Linux-64bit.deb
sudo dpkg -i trivy_0.21.0_Linux-64bit.deb
```
Check the version:
```
trivy --version
```
**Adding User**
Create a user (Make sure to replace `giles` with your own name):
```
adduser giles
```
Disable user `password` and add user to the `sudoers group`:
```
echo "giles ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/giles
```
Add user to `docker group`:
```
usermod -aG docker giles
```
Temporally change the `Hostname`:
```
hostname dev-ENV
```
Switch to giles user:
```
su - giles
```
**Create your project repository**
Create your project repository:
```
mkdir docker_project
```
Change to docker_project directory:
```
cd docker_project
```
Clone your GitHub repository
```
git clone your-github-project-url
```
Change to this directory:
```
cd your-github-project-directory
```
**Dockerfile**
Create your Dockerfile:
```
nano Dockerfile
```
Add the Dockerfile content:
```
# Use the official nginx image as the base image
FROM nginx:latest

# Remove the default nginx index.html file
RUN rm /usr/share/nginx/html/*

# Copy website files to the nginx html directory
COPY . /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Command to run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
```
**Build the Docker image**
```
docker build -t <image-name> .
```
**Scan the image for Vulnerabilities**
Scan the image using trivy:
```
trivy image <image-name>
```
**Push Image to DockerHub**
Before you can push the image to DockerHub, you have to first of all Tag your image:
```
docker tag image-name:tag dhub-username/image-name:tag 
```
Login to DockerHub:
```
docker login -u dockerhub-user-name 
```
Push image to DockerHub
```
docker push <tagged-image>
```
## Prod Instance
Become root:
```
sudo -i
```
Update and updgrade your Server
```
apt update
```
```
apt upgrade -y
```
**Install java as a prerequisite:**
```
apt install default-jre -y
```
**Install net-tools:**
```
apt install net-tools
```
**Install Docker:**
```
apt install docker.io -y
```
Change docker.sock permissions to be readable and writeable by all users:
```
chmod 666 /var/run/docker.sock
```
Enable Docker: 
```
systemctl enable docker 
```
Start Docker:
```
systemctl start docker
```
Check Docker status:
```
systemctl status docker
```
Install trivy:
```
wget https://github.com/aquasecurity/trivy/releases/download/v0.21.0/trivy_0.21.0_Linux-64bit.deb
sudo dpkg -i trivy_0.21.0_Linux-64bit.deb
```
Check the version:
``` 
trivy --version
```
**Adding Users:**
Create a user (Makes sure to replace giles with your own name):
```
adduser giles
```
Disable user password and add user to the Sudoer group:
```
echo "giles ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/giles
```
Add user to docker group:
```
usermod -aG docker giles
```
Temporally change the Hostname:
```
hostname dev-PROD
```
Switch to giles user:
```
su - giles
```
**Pull your Docker image from DockerHub:**
```
docker pull image-name 
```
**Scan your image for Vulnerabilities**
Scan your image using trivy:
```
trivy image <image-name>
```
**Create a Custom Bridge Network:**
```
docker network create giles-network
```
**Create a Volume to persist your data:**
```
docker volume create giles-volume
```
Run your container and attached it to the network and volume:
```
docker run -d --name my-container --network giles-network -v giles-volume:/data -p 80:80 vin-image:1
```
## NOTE
Don't forget to replace the following with your own names:
- Container name
- Image name
- Volume name
- Network name

## Show your website on a browser
Get your Instance IP

Copy and paste it on a Browser



