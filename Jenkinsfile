pipeline {
    agent any
   environment {
        DOCKER_IMAGE = "sachin93094/python-project:v1"
        DOCKER_HUB_CREDENTIALS = "11"
        GIT_REPO = "https://github.com/sachinsdevops/sample_teamcity.git"
        GIT_BRANCH = "project"
    }

    stages {
        stage('checkout github repo') {
            steps {
                git branch: 'project', credentialsId: '77', url: 'https://github.com/sachinsdevops/sample_teamcity.git'
            }
        }

        stage('build docker image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: '11') {
                        sh "docker push ${DOCKER_IMAGE}"
                    }
                }
            }
        }   
        stage('Run docker container') {
            steps {
                withCredentials([usernamePassword(credentialsId: '77', usernameVariable:'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                   sh """
                   docker run --name c11 -p 8081:80 ${DOCKER_IMAGE} /bin/bash -c "
                   git clone https://${GIT_USER}:${GIT_PASS}@github.com/sachinsdevops/sample_teamcity.git && \
                   cd sample_teamcity && \
                   git checkout ${GIT_BRANCH} && \
                   python3 app.py
                "
                """ 
                }
            }
        }

        stage('clean up docker container') {
            steps {
                echo "delete docker container"
                sh '''
                docker stop c11 || true
                docker rm c11 || true
                docker ps -a
                docker images
                '''
            }
        }
    }
    post {
        always {
            echo "pipeline completed"
         }
    }
    
}
