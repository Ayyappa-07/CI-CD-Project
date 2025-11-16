pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'ayyuraj'
        DOCKERHUB_IMAGE = 'cicd-demo'
        EC2_IP = '13.127.180.149'
    }

    stages {
        stage('Build & Deploy on EC2') {
            steps {
                // Use your SSH credentials configured in Jenkins
                sshagent(['ec2-ssh-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@$EC2_IP '
                        # Clone the repo or pull latest changes
                        if [ ! -d /tmp/CI-CD-Project ]; then
                            git clone -b main https://github.com/Ayyappa-07/CI-CD-Project.git /tmp/CI-CD-Project
                        else
                            cd /tmp/CI-CD-Project
                            git reset --hard
                            git pull
                        fi

                        # Build Docker image
                        docker build -t $DOCKERHUB_USER/$DOCKERHUB_IMAGE:latest /tmp/CI-CD-Project

                        # Stop and remove old container if exists
                        docker stop $DOCKERHUB_IMAGE || true
                        docker rm $DOCKERHUB_IMAGE || true

                        # Run new container
                        docker run -d --name $DOCKERHUB_IMAGE -p 3000:3000 $DOCKERHUB_USER/$DOCKERHUB_IMAGE:latest
                    '
                    """
                }
            }
        }
    }
}
