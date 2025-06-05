pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'project ', credentialsId: '11', url: 'https://github.com/sachinsdevops/My-DevOps_project.git'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('MySonarQube') {
                    withCredentials([string(credentialsId: 'sonar-token', variable: 'SonarQubeToken')]) {
                        script {
                            def scannerHome = tool 'sonar-scanner'
                            sh """
                                ${scannerHome}/bin/sonar-scanner \
                                  -Dsonar.projectKey=my-devops-project \
                                  -Dsonar.sources=. \
                                  -Dsonar.host.url=http://13.200.242.206:9000 \
                                  -Dsonar.login=${SonarQubeToken}
                            """
                        }
                    }
                }
            }
        }
    }
}
