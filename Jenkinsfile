pipeline {
    agent any

    stages {
        stage('Git Clone') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], userRemoteConfigs: [[url: 'https://github.com/yoavshprungg/Devopsela.git']]])
            }
        }

        stage('Clean Up') {
            steps {
                deleteDir()
            }
        }

        stage('Pull Docker Image') {
            steps {
                script {
                    // Pull the Docker image from Docker Hub
                    def dockerImageTag = 'yoavshprung/today:latest'
                    sh "docker pull ${dockerImageTag}"
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run your tests using the pulled Docker image
                    def dockerImageTag = 'yoavshprung/today:latest'
                    sh "docker run -d --name myapp-test -p 5000:5000 ${dockerImageTag}"
                    sleep 10
                    def responseCode = sh(script: 'curl -s -o /dev/null -w "%{http_code}" http://localhost:5000', returnStatus: true)
                    if (responseCode != 200) {
                        error("Application test failed with response code ${responseCode}")
                    }
                    sh "docker stop myapp-test"
                    sh "docker rm myapp-test"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Perform the deployment (e.g., using kubectl)
                    sh "kubectl apply -f deployment.yaml -f service.yaml -n dolphine_kubernetes"
                }
            }
        }
    }
}

