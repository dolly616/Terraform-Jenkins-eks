pipeline{
    agent any
    environment {
            AWS_ACCESS_KEY_ID = credentials("AWS_ACCESS_KEY_ID") 
            AWS_SECRET_ACCESS_KEY = credentials("AWS_SECRET_ACCESS_KEY")
            AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage ("Checkout SCM") { 
           steps{
             script{
                 checkout scmGit(branches: [[name: '*/Master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bandnajha/tf-jenkins-eks.git']])
                }
            }
            
        }
        stage("Initializing Terraform"){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform init'
                    }
                }
            }
        }
        stage("Formatting Terraform code"){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage("validating Terraform code"){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage("previewing the Infra using Terraform"){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform plan'
                    }
                    input(message: "Are you sure to proceed?", ok: "Proceed")
                }
            }
        }
        stage("creating an EKS cluster"){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform apply --auto-approve'
                    }
                }
            }
        }
        stage("Deploying Nginx application"){
            steps{
                script{
                    dir("EKS/Configuration files"){
                        sh 'aws eks update-kubeconfig --name my-eks-cluster'
                        sh 'kubectl apply -f deployment.yaml'
                        sh 'kubectl apply -f service.yaml'
                    }
                }
            }
        }
    }
}
