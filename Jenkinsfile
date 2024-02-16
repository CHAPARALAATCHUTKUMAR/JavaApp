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

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'sudo docker build -t public.ecr.aws/o5y1r0b2/kumardevops:tomcat .'
                }
            }
        }
        stage('Trivy Image Scan') {
            steps {
                script {
                    sh 'wget https://github.com/aquasecurity/trivy/releases/download/v0.20.0/trivy_0.20.0_Linux-64bit.tar.gz'
                    sh 'tar zxvf trivy_0.20.0_Linux-64bit.tar.gz'
                    sh 'sudo mv trivy /usr/local/bin/'
                    sh 'trivy image -s HIGH,CRITICAL public.ecr.aws/o5y1r0b2/kumardevops:tomcat'
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
             // Authenticate Docker to your ECR registry
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_CRED', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        sh 'aws ecr-public get-login-password --region us-east-1 |sudo docker login --username AWS --password-stdin public.ecr.aws/o5y1r0b2'
                        }
            
            // Push the Docker image to ECR
                        sh 'sudo docker push public.ecr.aws/o5y1r0b2/kumardevops:tomcat'
                }
            }
        }

    }
}
