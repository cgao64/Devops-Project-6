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
}