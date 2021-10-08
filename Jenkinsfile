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
                    sh '''docker run --name test-app -p 8090:8080 -d maxm18/pet-clinic
                    #sleep 30
                    test=$(curl -sIL http://localhost:8090/ | grep "HTTP.*\\s200")
                    docker stop test-app && docker rm test-app
                    if [[ -z "$test" ]]; then exit 25; fi
                    '''
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
                        sh "docker stop pet-clinic && docker rm pet-clinic || exit 0"
                        sh "docker run  --name pet-clinic -p 8080:8080 -d maxm18/pet-clinic:${env.BUILD_NUMBER}"
                }
            }
        }
    }   
}
