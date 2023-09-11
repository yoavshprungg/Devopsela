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

        stage('Build') {
            steps {
                dir('/var/lib/jenkins/workspace/yoavyo/Devopsela') {
                    script {
                        // withCredentials([usernamePassword(credentialsId: 'b02aac4f-a3b2-4c78-bcca-186675d3b9df', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                        sudo docker build -t yoavshprung/today:latest .
                        sudo docker push yoavshprung/today:latest
                        """
                        // }
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh "docker run -d --name myapp-test -p 5000:5000 ${dockerImageTag}"
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

