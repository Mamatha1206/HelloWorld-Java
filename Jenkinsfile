pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mamatha0124/helloworld-java:v3'
        DOCKER_CREDENTIALS_ID = 'DOCKER_CREDENTIALS_ID'  // Replace with actual Jenkins credentials ID
        KUBE_CREDENTIALS_ID = 'kubeconfig'  // Ensure correct Kubernetes credentials ID
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo "🔄 Cloning repository..."
                git branch: 'main', url: 'https://github.com/Mamatha1206/helloworld-java.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "🐳 Building Docker image..."
                    try {
                        sh "docker build -t ${DOCKER_IMAGE} ."
                    } catch (Exception e) {
                        error "🚨 Docker build failed: ${e}"
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "📤 Pushing Docker image to Docker Hub..."
                    withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: 'https://index.docker.io/v1/']) {
                        try {
                            sh "docker push ${DOCKER_IMAGE}"
                        } catch (Exception e) {
                            error "🚨 Docker push failed: ${e}"
                        }
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    echo "🚀 Deploying application to Kubernetes..."
                    withKubeConfig([credentialsId: KUBE_CREDENTIALS_ID]) {
                        try {
                            sh 'kubectl apply -f deployment.yaml'
                            sh 'kubectl apply -f service.yaml'
                        } catch (Exception e) {
                            error "🚨 Kubernetes deployment failed: ${e}"
                        }
                    }
                }
            }
        }

        stage('Scale Deployment Up') {
            steps {
                script {
                    echo "📈 Scaling up deployment..."
                    sh 'kubectl scale deployment helloworld-deployment --replicas=3'
                }
            }
        }

        stage('Scale Deployment Down') {
            steps {
                script {
                    input message: "⚠️ Do you want to scale down the deployment?", ok: "Yes"
                    echo "📉 Scaling down deployment..."
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
