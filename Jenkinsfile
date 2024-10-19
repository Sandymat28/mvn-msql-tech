pipeline {
  agent any // Utiliser n'importe quel agent disponible
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('DOCKER_ACCOUNT')
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t matsandy/lari:latest .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push matsandy/lari:latest'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}
