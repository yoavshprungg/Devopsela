pipeline {
    agent any
    
    stages {
        stage('Git Clone') {
            steps {
                // Checkout the code from the repository
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/yoavshprungg/Devopsela.git']]])
            }
        }
        
        stage('Cleanup') {
            steps {
                // You can perform any necessary cleanup here, like deleting old build artifacts
                sh 'rm -rf venv'
                sh 'rm -rf __pycache__'
            }
        }
        
        stage('Build') {
            steps {
                // Set up your virtual environment and install dependencies
                sh 'python3 -m venv venv'
                sh 'source venv/bin/activate'
                sh 'pip install -r requirements.txt'
            }
        }
        
        stage('Test') {
            steps {
                // Run tests
                sh 'python -m unittest discover tests'
            }
        }
        
        stage('Deploy') {
            steps {
                // Here you can define your deployment steps (e.g., deploying to a server)
                // Replace the following line with actual deployment commands
                sh 'echo "Deploying the app"'
            }
        }
    }
    
    post {
        always {
            // Clean up your environment after the pipeline
            sh 'deactivate'
        }
        success {
            echo 'CI/CD pipeline succeeded!'
        }
        failure {
            echo 'CI/CD pipeline failed!'
        }
    }
}

