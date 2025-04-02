pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mamatha0124/helloworld-java:v3'
        DOCKER_CREDENTIALS_ID = 'mamatha0124'
        KUBE_CREDENTIALS_ID = 'kubeconfig'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git (url : 'https://github.com/Mamatha1206/helloworld-java.git', branch:'main')
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t mamatha0124/helloworld-java:v3 .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: 'https://hub.docker.com/repository/docker/mamatha0124/helloworld-java/general']) {
                        sh 'docker push mamatha0124/helloworld-java:v3'
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withKubeConfig([credentialsId: KUBE_CREDENTIALS_ID]) {
                        sh 'kubectl apply -f deployment.yaml'
                        sh 'kubectl apply -f service.yaml'
                    }
                }
            }
        }

        stage('Scale Deployment Up') {
            steps {
                script {
                    sh 'kubectl scale deployment helloworld-deployment --replicas=3'
                }
            }
        }

        stage('Scale Deployment Down') {
            steps {
                script {
                    input message: "Scale down deployment?", ok: "Yes"
                    sh 'kubectl scale deployment helloworld-deployment --replicas=1'
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed! Check logs for errors."
        }
    }
}
