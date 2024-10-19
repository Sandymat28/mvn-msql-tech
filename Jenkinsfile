pipeline {
  agent any // Utiliser n'importe quel agent disponible
  /*tools {
    Maven maven:3.9.9
    }*/
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('DOCKER_ACCOUNT')
  }
  stages {
    stage('Build') {
      steps {
       //sh 'mvn clean package'
       //sh 'docker build -t matsandy/techstore-app-lari:lts .'
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
