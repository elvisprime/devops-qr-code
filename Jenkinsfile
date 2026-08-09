pipeline {
agent any

environment {
    DOCKERHUB_USER = 'elvisprime'
    AWS_REGION     = 'eu-north-1'
    CLUSTER_NAME   = 'qr-cluster'
}

stages {
    stage('Checkout') {
        steps {
            checkout scm
            script {
                env.IMAGE_TAG = env.GIT_COMMIT.take(7)
            }
        }
    }

    stage('Build Images') {
        steps {
            sh "docker build -t ${DOCKERHUB_USER}/qr-api:${IMAGE_TAG} ./api"
            sh "docker build -t ${DOCKERHUB_USER}/qr-frontend:${IMAGE_TAG} ./front-end-nextjs"
        }
    }

    stage('Push Images') {
        steps {
            withCredentials([
                usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )
            ]) {
                sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                sh "docker push ${DOCKERHUB_USER}/qr-api:${IMAGE_TAG}"
                sh "docker push ${DOCKERHUB_USER}/qr-frontend:${IMAGE_TAG}"
            }
        }
    }

    stage('Deploy to EKS') {
        steps {
            withCredentials([
                [$class: 'AmazonWebServicesCredentialsBinding',
                 credentialsId: 'aws-creds']
            ]) {
                sh "aws eks update-kubeconfig --name ${CLUSTER_NAME} --region ${AWS_REGION}"

                sh "kubectl set image deployment/qr-api qr-api=${DOCKERHUB_USER}/qr-api:${IMAGE_TAG}"

                sh "kubectl set image deployment/qr-frontend qr-frontend=${DOCKERHUB_USER}/qr-frontend:${IMAGE_TAG}"

                sh "kubectl rollout status deployment/qr-api"

                sh "kubectl rollout status deployment/qr-frontend"
            }
        }
    }
}

post {
    success {
        echo "Deployed ${IMAGE_TAG} successfully."
    }

    failure {
        echo "Pipeline failed — check logs above."
    }
}

}