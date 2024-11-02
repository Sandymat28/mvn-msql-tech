pipeline {
  agent any // Utiliser n'importe quel agent disponible
  
  /*options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }*/
  
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
      
    
    // stage('Insatll_maven') {
    //   steps {
    //     sshagent(credentials: [SSH_CREDENTIALS_ID]) {
    //       sh """
    //           ssh -o StrictHostKeyChecking=no ${USERNAME}@${SERVER_IP} 'apt install maven' 
    //        """
    //     }
    //   }
    // }

    stage('Insatll_package') {
      steps {
        sshagent(credentials: [SSH_CREDENTIALS_ID]) {
          sh """
              ssh -o StrictHostKeyChecking=no ${USERNAME}@${SERVER_IP} 'cd /home/larissa/mvn-msql-tech && mvn clean package' 
           """
        }
      }
    }

    // stage('Insatll_package') {
    //   steps {
    //     sshagent(credentials: [SSH_CREDENTIALS_ID]) {
    //       sh """
    //           ssh -o StrictHostKeyChecking=no ${USERNAME}@${SERVER_IP} 'mvn clean package' 
    //        """
    //     }
    //   }
    // }

    stage('Build_image') {
      steps {
        sshagent(credentials: [SSH_CREDENTIALS_ID]) {
          sh """
              ssh -o StrictHostKeyChecking=no ${USERNAME}@${SERVER_IP} 'cd /home/larissa/mvn-msql-tech && docker build -t matsandy/techstore1-app-lari:lts .' 
           """
        }
      }
    }

    stage('Docker_build') {
      steps {
        sshagent(credentials: [SSH_CREDENTIALS_ID]) {
          sh """
              ssh -o StrictHostKeyChecking=no ${USERNAME}@${SERVER_IP} 'cd /home/larissa/mvn-msql-tech && docker compose build' 
           """
        }
      }
    }
    
    stage('Login') {
      steps {
        sshagent(credentials: [SSH_CREDENTIALS_ID]) {
          sh """
              ssh -o StrictHostKeyChecking=no ${USERNAME}@${SERVER_IP} 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin' 
           """
        }
      }
    }
    
    stage('Push') {
      steps {
        sshagent(credentials: [SSH_CREDENTIALS_ID]) {
          sh """
              ssh -o StrictHostKeyChecking=no ${USERNAME}@${SERVER_IP} 'docker push matsandy/techstore1-app-lari:lts' 
          """
        }
      }
    }
  }
}


  
 /* post {
    always {
      sh 'docker logout'
    }
  }*/
