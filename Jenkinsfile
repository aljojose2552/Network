pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    checkout scmGit(
                        branches: [[name: '*/main']],
                        extensions: [],
                        userRemoteConfigs: [[
                            credentialsId: 'githubtoken',  // Replace with your Jenkins credential ID
                            url: 'https://github.com/aljojose2552/Network.git'
                        ]]
                    )
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building the Docker image...'
                    sh 'docker build -t sample-html-app:latest .'
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    echo 'Deploying the Docker container...'

                    // Stop and remove the existing container if it exists
                    sh '''
                    if [ $(docker ps -aq -f name=my-container) ]; then
                        docker stop my-container || true
                        docker rm my-container || true
                    fi
                    '''

                    // Run the new container with the built image
                    sh 'docker run -d -p 3000:80 --name my-container sample-html-app:latest'
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up unused Docker images...'
                sh 'docker image prune -f'
            }
        }
    }
}
