pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'ayyuraj'
        DOCKERHUB_IMAGE = 'cicd-demo'
    }

    stages {
        stage('Build & Deploy on EC2') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@<YOUR_EC2_IP> '
                        if [ ! -d /tmp/ci-cd ]; then
                            git clone -b main https://github.com/<YOUR_GITHUB_USERNAME>/ci-cd-demo.git /tmp/ci-cd
                        else
                            cd /tmp/ci-cd
                            git reset --hard
                            git pull
                        fi

                        docker build -t $DOCKERHUB_USER/$DOCKERHUB_IMAGE:latest /tmp/ci-cd
                        docker stop $DOCKERHUB_IMAGE || true
                        docker rm $DOCKERHUB_IMAGE || true
                        docker run -d --name $DOCKERHUB_IMAGE -p 3000:3000 $DOCKERHUB_USER/$DOCKERHUB_IMAGE:latest
                    '
                    """
                }
            }
        }
    }
}
