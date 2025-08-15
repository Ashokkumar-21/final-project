pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'ashok2102'
        BRANCH = '${env.BRANCH_NAME}'
        DEV_REPO = 'dev'
        PROD_REPO = 'prod'
        TAG = 'v1'
        APP_SERVER_USER = 'ubuntu'
        APP_SERVER_IP = '65.2.177.203'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out branch: ${env.BRANCH_NAME}"
                checkout scm
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        echo "Logging in to DockerHub..."
                        sh 'echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin'

                        echo "Building Docker Image for branch: ${env.BRANCH_NAME}"
                        sh 'chmod +x build.sh'
                        sh './build.sh'
                    }
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                script {
                    echo "Deploying Final Project Application..."
                    sh 'chmod +x deploy.sh'
                    sh './deploy.sh'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline Completed — Application Successfully Deployed!'
        }
        failure {
            echo '❌ Pipeline Ended with Error!'
        }
    }
}
