pipeline {
    agent any

    tools {
        nodejs 'NODE_22'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github', url: 'https://github.com/Routparesh/simple-node-app'
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    sh 'docker build -t routparesh/simple-node-app:latest .'
                    sh 'docker login -u routparesh -p 13M@l4124'
                    sh 'docker push routparesh/simple-node-app:latest'
                }
            }
        }

        stage('Deploy') {
            steps {
                    sh '''
                      if [ "$(docker ps -aq -f name=simple-node-app)" ]; then
                          docker stop simple-node-app || true
                          docker rm simple-node-app || true
                      fi

                      docker run -d --name simple-node-app -p 5000:5000 routparesh/simple-node-app:latest
                    '''
            }
        }
    }
}
