pipeline {
  agent any
    tools {
       terraform 'terraform'
    }
    stages {
        stage('terraform format') {
            steps{
                withAWS(credentials: 'AWS_KEYS', region: 'us-east-1') {
                sh 'terraform fmt'
                }
            }
        }
        stage('terraform init'){
          steps{
             withAWS(credentials: 'AWS_KEYS', region: 'us-east-1') {
                sh 'terraform init'
                }
          }
        }
        stage('terraform build'){
          steps{
             withAWS(credentials: 'AWS_KEYS', region: 'us-east-1') {
                sh 'terraform apply --auto-approve --var-file dev.tfvars'
                }
          }
        }
        stage('Testing outcome of local provisioner'){
          steps{
            sh 'cat ./ansible/group_vars/proxy.yaml'
            sh 'cat ./ansible/group_vars/slaves.yaml'
            sh 'cd ansible'
            sh 'ansible --version'
            ansiblePlaybook( 
              playbook: '/var/jenkins_home/workspace/infrastructure-pipeline/ansible/ping.yaml',
              inventory: '/var/jenkins_home/workspace/infrastructure-pipeline/ansible/inventory', 
              credentialsId: 'ansible-us-east',
              colorized: true) 
            }
        }
    // stage('clean workspace') {
    //   steps {
    //     cleanWs()
    // }   
    // }
    }
     
  }