pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'ayyuraj'
        DOCKERHUB_IMAGE = 'cicd-demo'
        EC2_IP = '13.233.193.15'
    }

    stages {
        stage('Build & Deploy on EC2') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@$EC2_IP '
                        if [ ! -d /tmp/CI-CD-Project ]; then
                            git clone -b main https://github.com/Ayyappa-07/CI-CD-Project.git /tmp/CI-CD-Project
                        else
                            cd /tmp/CI-CD-Project
                            git reset --hard
                            git pull
                        fi

                        docker build -t $DOCKERHUB_USER/$DOCKERHUB_IMAGE:latest /tmp/CI-CD-Project
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
