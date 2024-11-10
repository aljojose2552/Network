# Jenkins Installed:
sudo apt update
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
# Add Jenkins User to the Docker Group
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

Install Jenkins on the EC2 instance 
Git Repository:A Git repository for the application source code, with a Dockerfile in the root directory for containerization.
Once Jenkins is installed, navigate to Manage Jenkins > Manage Plugins and install:
             Git Plugin
            Docker Pipeline Plugin
             Pipeline Plugin
Configure Docker on Jenkins Host
Configure Credentials
Add your Git credentials to Jenkins for repository access.
create pipeline
    Go to Jenkins Dashboard > New Item.
    Enter  jobname, select Pipeline, and click OK
Select Git and enter the repository URL.
main branch to build 
Add the path to the 'Jenkinsfile'
create jenkinsfile
Once the Jenkins job is configured:
Click Build Now to start the pipeline.
# Troubleshooting
EC2 SSH Access: Verify that the SSH key is correctly configured in Jenkins and the EC2 instance allows inbound connections on the required ports (e.g., 80 for HTTP).

