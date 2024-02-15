pipeline {
    agent { label 'Jenkins-Slave' }

    stages {
        stage('Clone and Build') {
            steps {
                // Clean workspace
                deleteDir()

                // Checkout code from Git
                checkout([$class: 'GitSCM', 
                          branches: [[name: '*/main']], 
                          userRemoteConfigs: [[url: 'https://github.com/CHAPARALAATCHUTKUMAR/JavaApp.git']]])

                // Build with Maven
                sh 'mvn clean install'
            }
        }

        stage('Run Tests') {
            steps {
                // Run JUnit tests
                sh 'mvn test'
            }
        }

        stage('Build Docker Image for Tomcat') {
            steps {
                script {
                    sh 'ls -lart'
                    sh 'mkdir -p docker-build && cd docker-build && ls -lart'
                    
                    // Copy the Dockerfile and built artifact to the existing workspace
                    sh 'cp Dockerfile target/JavaApp-1.0-SNAPSHOT.jar docker-build/'

                    // Build Docker image with Tomcat and the copied artifact
                    sh 'sudo docker build -t public.ecr.aws/o5y1r0b2/kumardevops:tomcat docker-build/'
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    // Authenticate Docker to your ECR registry
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/o5y1r0b2/kumardevops"
                    }

                    // Push the Docker image to ECR
                    sh 'sudo docker push public.ecr.aws/o5y1r0b2/kumardevops'
                }
            }
        }



        stage('List Contents of target Directory') {
            steps {
                // List contents of the target directory
                sh 'ls -l target/'
            }
        }
    }
}
