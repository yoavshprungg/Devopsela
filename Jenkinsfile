pipeline {
    agent any
    environment {
        dockerImageTag = "yoavshprung/today:latest"
    }
    triggers {
        pollSCM('H * * * *')
    }
    stages {
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

        stage('Test') {
            steps {
                script {
                    sh "sudo docker stop myapp-test || true"
                    sh "sudo docker rm myapp-test || true"
                    
                    sh "sudo docker run -d --name myapp-test -p 5000:5000 ${dockerImageTag}"
                    sleep 10
                    if (responseCode != 200) {
                        error("Application test failed with response code ${responseCode}")
                    }
                    sh "sudo docker stop myapp-test"
                    sh "sudo docker rm myapp-test"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh "kubectl apply -f kubernetes/deployment.yaml -f kubernetes/service.yaml -n dolphine_kubernetes"
                }
            }
        }
    }
}

