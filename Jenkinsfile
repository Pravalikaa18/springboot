pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'pravalikaa18/java-application:${BUILD_NUMBER}' // Unique versioned image
        DOCKER_CREDENTIALS = '98897e03-c137-4438-8da4-dd1f33b63fba' // Jenkins Docker Hub Credentials I
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    git branch: 'main', url: 'https://github.com/pravalikaa18/springboot.git'
                }
            }
        }

        stage('Build with Maven') {
            
            steps {
                script {
                    sh 'mvn clean package -DskipTests=true'
                }
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
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                        sh "docker push ${DOCKER_IMAGE}"
                        sh "docker logout"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                        sh "kubectl apply -f deployment.yaml"
                        sh "kubectl apply -f service.yaml"
                    }
                }
            }
        }
    }

    post {
        failure {
            echo "Pipeline failed! Check the logs for details."
        }
        success {
            echo "Deployment successful! 🚀"
        }
    }
}
