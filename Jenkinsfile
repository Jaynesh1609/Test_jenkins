pipeline {
    agent any
    environment {
        PROJECT_ID = '<<Your GCP Project ID>>'
        CLUSTER_NAME = '<<Your GKE Cluster Name>>'
        LOCATION = '<<Your GKE Cluster Location>>'
        CREDENTIALS_ID = 'multi-k8s'
    }
//     stage("Git Clone") {
//       git credentialsId: 'GIT_HUB_CREDENTIALS', url: 'https://github.com/rahulwagh/k8s-jenkins-aws'
//     }
    stages {
        stage("Checkout code") {
            steps {
                checkout scm
            }
        }
      
    stage("Docker build"){
      sh 'docker version'
      sh 'docker build -t jenkins-docker .'
      sh 'docker image list'
      sh 'docker tag jenkins-docker jaynesh169/jenkins-docker-demo'
    }  
    
    withCredentials([string(credentialsId: 'DOCKER_HUB_PASSWORD', variable: 'PASSWORD')]) {
        sh 'docker login -u jaynesh169 -p $PASSWORD'
    }

    stage("Push Image to Docker Hub"){
        sh 'docker push  jaynesh169/jenkins-docker:jenkins-docker'
    }
    stage('Deploy to GKE') {
        steps{
            // sh "sed -i 's/hello:latest/hello:${env.BUILD_ID}/g' deployment.yaml"
            step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
        }
}   
//         stage("Build image") {
//             steps {
//                 script {
//                     myapp = docker.build("<<Your DockerHub username>>/hello:${env.BUILD_ID}")
//                 }
//             }
//         }
//         stage("Push image") {
//             steps {
//                 script {
//                     docker.withRegistry('https://registry.hub.docker.com', 'dockerID') {
//                             myapp.push("latest")
//                             myapp.push("${env.BUILD_ID}")
//                     }
//                 }
//             }
//         }        
//         stage('Deploy to GKE') {
//             steps{
//                 sh "sed -i 's/hello:latest/hello:${env.BUILD_ID}/g' deployment.yaml"
//                 step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
//             }
//         }
//     }    
// }
