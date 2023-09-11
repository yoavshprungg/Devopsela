pipeline {
    agent any
    environment {
        dockerImageTag = "1.${env.BUILD_NUMBER}"
    }
    triggers {
        // Checking for commits on GitHub every hour 
        pollSCM('H * * * *')
    }
    stages {
            stage('Git Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], userRemoteConfigs: [[url: 'https://github.com/yoavshprungg/Devopsela.git']]])
            }
        }
        
        stage('Clean Up') {
            steps {
                deleteDir()
            }
        }

        stage('Git Clone') {
            steps {
                sh "git clone 'https://github.com/yoavshprungg/Devopsela.git'"
            }
        }

        stage('Build') {
            steps {
                dir('/var/lib/jenkins/workspace/yoavyo/Devopsela') {
                    script {
                        sh """
                        sudo docker build -t yoavshprung/today:${dockerImageTag} .
                        sudo docker push yoavshprung/today:${dockerImageTag}
                        """
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh "sudo docker run -d --name myapp-test -p 5000:5000 ${dockerImageTag}"
                    sleep 10
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
                    sh "kubectl apply -f deployment.yaml -f service.yaml -n dolphine_kubernetes"
                }
            }
        }
    }
}

