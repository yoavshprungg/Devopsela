pipeline {
    agent any

    stages {
        stage('Git Clone') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/yoavshprungg/Devopsela.git']]])
            }
        }

        stage('Clean Up') {
            steps {
                deleteDir()
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def appVersion = env.BUILD_NUMBER ?: '1.0'
                    def dockerImageTag = "webapp:${appVersion}"
                    
                    sh "docker build -t ${dockerImageTag} -f Dockerfile ."
                    
                    env.DOCKER_IMAGE_TAG = dockerImageTag
                }
            }
            
            post {
                success {
                    script {
                        sh "docker login"
                        
                        sh "docker push ${env.DOCKER_IMAGE_TAG}"
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh "docker run -d --name myapp-test -p 5000:5000 ${env.DOCKER_IMAGE_TAG}"
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
                    sh "kubectl apply -f deployment.yaml -f service.yaml -n dolphine_kubernetes"
                }
            }
        }
    }
}
