pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'ashok2102'
        BRANCH = '${env.BRANCH_NAME}'
        DEV_REPO = 'dev'
        PROD_REPO = 'prod'
        TAG = 'v1'
        APP_SERVER_USER = 'ubuntu'
        APP_SERVER_IP = '13.233.254.167'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking SCM'
                checkout scm
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                echo 'Building Docker Image'
                sh 'chmod +x build.sh'
                sh './build.sh'
            }
        }

        stage('Deploy to Server') {
            steps {
                echo 'Deploying Final Project Application'
                sh 'chmod +x deploy.sh'
                sh './deploy.sh'
            }
        }
    }

    post {
        success {
            echo 'Pipeline Completed, Final Project Application Successfully Deployed!'
        }
        failure {
            echo 'Pipeline Endup with Error!'
        }
    }
}
