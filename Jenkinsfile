pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'ashok2102'
        DEV_REPO = 'dev'
        PROD_REPO = 'prod'
        TAG = 'v1'
        APP_SERVER_USER = 'ubuntu'
        APP_SERVER_IP = '13.233.114.212'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out branch: ${env.BRANCH_NAME}"
                checkout scm
            }
        }

        stage('Build, Tag & Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', 
                                                     usernameVariable: 'DOCKER_USER', 
                                                     passwordVariable: 'DOCKER_PASS')]) {
                        echo "Logging in to DockerHub..."
                        sh 'echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin'

                        def repoName = (env.BRANCH_NAME == 'main') ? PROD_REPO : DEV_REPO
                        def imageName = "${DOCKERHUB_USER}/${repoName}:${TAG}"

                        echo "Building Docker Image: ${imageName}"
                        sh "chmod +x build.sh"
                        sh "./build.sh ${env.BRANCH_NAME} ${TAG}"

                        echo "Deploying image on ${APP_SERVER_USER}"
                        sshagent(credentials: ['ssh-key']) {
                            sh """
                                ssh -o StrictHostKeyChecking=no ${APP_SERVER_USER}@${APP_SERVER_IP} '
                                chmod +x /home/ubuntu/deploy.sh || true
                                /home/ubuntu/deploy.sh ${imageName}
                                '
                            """
                        }
                    }
                }
            }
        }
    }
}
