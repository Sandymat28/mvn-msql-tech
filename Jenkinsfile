pipeline {
  agent any // Utiliser n'importe quel agent disponible
  
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  
  environment {
    DOCKERHUB_CREDENTIALS = credentials('DOCKER_ACCOUNT')
    SSH_CREDENTIALS_ID = 'remote_credentials' // ID des credentials SSH dans Jenkins
    SERVER_IP = '192.168.1.124'
    USERNAME = 'larissa'
  }
  
  stages {
    stage('Verify SSH Connection') {
            steps {
                sshagent(credentials: [SSH_CREDENTIALS_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${USERNAME}@${SERVER_IP} 'echo "Connection successful!"' 
                    """
                }
            }
        }
    
    stage('Build') {
      steps {
       //sh 'mvn clean package'
        sh 'docker build -t matsandy/techstore-app-lari:lts .'
        sh 'docker-compose build'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push matsandy/techstore-app-lari:lts'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}
