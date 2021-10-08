pipeline {
  agent {label 'slave'}
    stages {
        stage('Build') {
            steps {
                echo 'Running build automation'
                sh './mvnw package'
                archiveArtifacts 'target/*.jar'
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
    }   
}
