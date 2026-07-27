pipeline {
    agent any

    tools {
        maven 'mavn3'
    }

    environment {
        // Docker Image Details
        IMAGE_NAME = "sidhu9676/devops-lab"
        IMAGE_TAG = "${BUILD_NUMBER}"

        // Docker Container Name
        CONTAINER_NAME = "devops-lab-container"

        // Docker Hub Credentials
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
    }

    stages {

        stage('Build with Maven') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }

        stage('Package JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Push Docker Image') {
    steps {
        script {
           withCredentials([usernamePassword(credentialsId: '8204ae2f-29a5-467e-8427-cd49e49058ec', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
    sh '''
        echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
        docker push sidhu9676/devops-lab:20
    '''
}
        }
    }
}

        stage('Deploy Container') {
            steps {
                sh '''
                    docker rm -f ${CONTAINER_NAME} || true

                    docker run -d \
                      --name ${CONTAINER_NAME} \
                      -p 8080:8080 \
                      ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline executed successfully."
        }

        failure {
            echo "Pipeline failed."
        }

        always {
            sh 'docker logout || true'
        }
    }
}
