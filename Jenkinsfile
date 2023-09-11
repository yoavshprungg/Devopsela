pipeline {
    agent any
    environment {
        dockerImageTag = "1.${env.BUILD_NUMBER}"
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
                    sh "sudo docker run -d --name myapp-test -p 5000:5000 yoavshprung/today:${dockerImageTag}"
                    sleep 10
                    def responseCode = sh(script: "curl -s -o /dev/null -w \"%{http_code}\" http://localhost:5000", returnStatus: true)

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

