pipeline {
  agent { label 'slave' }
    stages {
        stage('Build') {
            steps {
                sh './mvnw package'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    app = docker.build("maxm18/pet-clinic")
                    app.inside {
                        sh 'echo $(curl localhost:8080)'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage ('DeployImage') {
            steps {
                script {
                        sh "docker pull maxm18/pet-clinic:${env.BUILD_NUMBER}"
                        sh "docker kill maxm18/pet-clinic"
                        sh "docker run  --name pet-clinic -p 8080:8080 -d maxm18/pet-clinic:${env.BUILD_NUMBER}"
                }
            }
        }
    }   
}
