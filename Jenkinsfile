pipeline {
    agent { label 'Jenkins-Slave' }

    stages {
        stage('Clone and Build') {
            steps {
                // Clean workspace
                deleteDir()

                // Checkout code from Git
                git 'https://your-git-repo-url.git'

                // Build with Maven
                sh 'mvn clean install'
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
