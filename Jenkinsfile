pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mamatha0124/helloworld-java:v3'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Mamatha1206/helloworld-java.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig([credentialsId: 'kubeconfig']) {
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }

        stage('Scale Deployment Up') {
            steps {
                sh 'kubectl scale deployment helloworld-deployment --replicas=3'
            }
        }

        stage('Scale Deployment Down') {
            steps {
                input message: "Scale down deployment?", ok: "Yes"
                sh 'kubectl scale deployment helloworld-deployment --replicas=1'
            }
        }
    }
}
