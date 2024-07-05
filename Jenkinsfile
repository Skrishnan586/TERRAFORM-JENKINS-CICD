pipeline {
    agent any

    tools {
        jdk 'jdk17'
        terraform 'terraform'
    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout from Git') {
            steps {
                git branch: 'main', url: 'https://github.com/Skrishnan586/TERRAFORM-JENKINS-CICD.git'
            }
        }

        stage('Terraform version') {
            steps {
                sh 'terraform --version'
            }
        }

        stage("Sonarqube Analysis") {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh """$SCANNER_HOME/bin/sonar-scanner \
                        -Dsonar.projectName=Terraform \
                        -Dsonar.projectKey=Terraform"""
                }
            }
        }

        stage("Quality Gate") {
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'Sonar-token'
                }
            }
        }

        stage('TRIVY FS SCAN') {
            steps {
                sh "trivy fs . > trivyfs.txt"
            }
        }

        stage("Manual Approval to run TF scripts") {
            steps {
                input message: "Execute TF scripts?", ok: 'Execute', submitter: 'approver'
            }
        }

        stage('Executable permission to userdata') {
            steps {
                sh 'chmod 777 website.sh'
            }
        }

        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
    }
}
