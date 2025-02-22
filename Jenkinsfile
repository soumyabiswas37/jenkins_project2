pipeline {
    agent {
        label 'Build'
    }
    stages {
        retry(conditions: [nonresumable()], count: 4) {
            stage ("Installing Git and Docker") {
                steps {
                    sh "sudo yum install docker git -y"
                    sh "sudo service docker start"
                    sh "sudo service docker status"
                }
            }
        }
        stage("Pull,Build,Verify image") {
            steps {
                sh 'echo "Pulling Docker File from Github"'
                sh 'sudo git init'
                sh 'sudo git clone https://github.com/soumyabiswas37/jenkins_project2.git'
                sh 'echo "Bilding Docker image and check the status"'
                sh 'sudo docker build -t mynewimage:v$BUILD_NUMBER .'
                sh 'sudo docker images | grep "mynewimage"'
            }
        }
        stage("Approval Required") {
            steps {
                script {
                    input message: 'Do you want to proceed to the next stage?', ok: 'Yes'
                }
            }
        }
        stage("Build Container") {
            steps {
                sh 'echo "Building Docker container"'
                sh "echo $BUILD_NUMBER"
                sh 'sudo docker run -d --name container_$BUILD_NUMBER -p 30$BUILD_NUMBER:3000 mynewimage:v$BUILD_NUMBER'
                sh 'sudo docker ps -a | grep $BUILD_NUMBER'
            }
        }
        stage("Clean Workspace") {
            steps {
                cleanWs()
            }
        }
    }
}
