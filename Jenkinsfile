pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Replace 'REPO_URL' with your Git repository URL
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'REPO_URL']]])
            }
        }

        stage('Clean Up') {
            steps {
                // Add cleanup steps if needed
                sh 'rm -rf build/ dist/'
            }
        }

        stage('Build') {
            steps {
                // Replace with your build commands
                sh 'npm install'  // For example, if using Node.js
            }
        }

        stage('Test') {
            steps {
                // Replace with your test commands
                sh 'npm test'  // For example, if using Node.js
            }
        }

        stage('Deploy') {
            steps {
                // Replace with your deployment commands
                sh 'kubectl apply -f kubernetes/deployment.yaml'  // Example Kubernetes deployment
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

