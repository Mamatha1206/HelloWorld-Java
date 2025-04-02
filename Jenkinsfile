pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mamatha0124/helloworld-java:v3'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'  // Use your correct Jenkins Docker credentials ID
        KUBE_CREDENTIALS_ID = 'kubeconfig'  // Ensure correct Kubernetes credentials ID
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Mamatha1206/helloworld-java.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: 'https://index.docker.io/v1/']) {
                        sh "docker push ${DOCKER_IMAGE}"
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
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed! Check logs for errors."
        }
    }
}
