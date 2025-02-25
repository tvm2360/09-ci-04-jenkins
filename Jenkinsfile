pipeline {
    agent {
        label 'ansible'
    }
    stages {
        stage('1') {
            steps {
                sh 'rm -rf ./08-ansible-05-testing'
            }
        }
        stage('2') {
            steps {
                sh 'git clone https://github.com/tvm2360/08-ansible-05-testing.git'
            }
        }
        stage('3') {
            steps {
                sh 'cd ./08-ansible-05-testing/playbook/roles/vector'
            }
        }
        stage('4') {
            steps {
                sh 'molecule test -s default'
            }
        }
    }
}