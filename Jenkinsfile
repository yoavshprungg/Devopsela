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

        stage('Build') {
            steps {
                dir('/var/lib/jenkins/workspace/yoavyo/Devopsela') {
                    script {
                        sh """
                        sudo docker build -t ${dockerImageTag} .
                        sudo docker push ${dockerImageTag}
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
                        error("Application test failed with response code yoavshprung/today:${responseCode}")
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
