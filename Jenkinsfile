pipeline {
    agent any
    
    triggers {
        pollSCM('*/5 * * * *') 
    }

    stages {
        stage('Clone') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/yoavshprungg/Devopsela.git']]])
            }
        }

        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Build') {
            steps {
                script {

                    sudo docker build -t yoavshprung/today:latest .

                }
            }
        }

        stage('Test') {
            steps {
                script {

                    sh 'docker run yoavshprung/today:latest ./run-tests.sh'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {

                    sh 'kubectl apply -f kubernetes-deployment.yaml'
                }
            }
        }
    }
}

