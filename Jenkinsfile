pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[
                        credentialsId: 'githubtoken',
                        url: 'https://github.com/aljojose2552/Network.git'
                    ]]
                )
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t my-docker-image:latest .'
                }
            }
        }
        stage('Deploy Docker Container') {
            steps {
                script {
                    // Stop and remove the existing container if it exists
                    sh '''
                    if [ $(docker ps -aq -f name=html-sample) ]; then
                        docker stop my-container
                        docker rm my-container
                    fi
                    '''

                    // Run the new container with the latest image
                    sh 'docker run -d -p 3000:80 --name my-container my-docker-image:latest'
                }
            }
        }
    }

    post {
        always {
            script {
                // Optional cleanup of old unused images
                sh 'docker image prune -f'
            }
        }
    }
}
