pipeline {
    agent any
    environment {
        dockerImageRepo = "yoavshprung/today"
        dockerImageTag = "latest"  
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
                        sudo docker build -t ${dockerImageRepo}:${dockerImageTag} .
                        sudo docker push ${dockerImageRepo}:${dockerImageTag}
                        """
                    }
                }
            }
        }

        stage('Test') {
            steps {
                dir('/var/lib/jenkins/workspace/yoavyo/Devopsela') {
                    script {
                        sh "sudo docker container prune -f"
                        sh "sudo docker run -d --name myapp-test -p 5000:5000 ${dockerImageRepo}:${dockerImageTag}"
                        sh "sleep 10"
                        sh "sudo chmod u+x tests.sh"
                        sh "./tests.sh"
                        sh "sudo docker stop myapp-test"
                        sh "sudo docker rm myapp-test"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                dir('/var/lib/jenkins/workspace/yoavyo/Devopsela') {
                    script {
                        sh "kubectl apply -f kubernetes/deployment.yaml -f kubernetes/service.yaml"
                        sh "kubectl rollout restart deployment.apps/web"
                    }
                }
            }
        }
    }
}

