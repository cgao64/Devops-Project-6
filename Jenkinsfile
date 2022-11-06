node {

    stage('Git checkout') {
        git 'https://github.com/cgao64/Devops-Project-6.git'
    }

    stage('Sending Docker file to Ansible server over SSH'){
        sshagent(['ansible_demo']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.1.110'
            sh 'scp /var/lib/jenkins/workspace/pipline-demo ubuntu@172.31.1.110:/home/ubuntu'
        }
    }

    stage('Docker Build Image') {
        sshagent(['ansible_demo']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.1.110 cd /home/ubuntu'
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.1.110 docker image build $JOB_NAME:v1.$BUILD_ID .'
        }
    }
    stage('Docker Image Tagging') {
        sshagent(['ansible_demo']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.1.110 cd /home/ubuntu'
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.1.110 docker image tag $JOB_NAME:v1.$BUILD_ID cgao64/$JOB_NAME:v1.$BUILD_ID'
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.1.110 docker image tag $JOB_NAME:v1.$BUILD_ID cgao64/$JOB_NAME:latest'
        }
    }    
    
    stage('Push Docker Images to Docker Hub') {
        sshagent(['ansible_demo']) {
            withCredentials([string(credentialsId: 'dockerhub_passwd', variable: 'dockerhub_passwd')])
                sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.1.110 docker login -u cgao64 -p ${dockerhub_passwd}"
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.1.110 docker image push cgao64/$JOB_NAME:latest'
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.1.110 docker image push cgao64/$JOB_NAME:latest'

                sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.1.110 docker image rm cgao64/$JOB_NAME:v1.$BUILD_ID'

        }
    }  

    stage('Copy files from Ansible to Kubernetes Server') {
        sshagent(['kubernetes_server'])
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.10.21'
            sh 'scp /var/lib/jenkins/workspace/pipeline-demo/* ubuntu@172.31.10.21:/home/ubuntu'

    }
}