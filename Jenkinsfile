env.REGION="us-east-1"
env.REGION2="us-west-1"

def login(command)
{
  result = sh "eval \$(/usr/local/bin/aws ecr get-login --no-include-email --region us-east-1)"
  if (result.length() > 0)
    echo result
  
  return result
}

pipeline {
    agent {
        label 'jenkins-ecs-slave'
    }
    environment { 
        GITURL="https://github.com/sfelinto/stone_challenge"
        CREDENTIALS="57db6742-0251-4c92-b060-9ba078e2dbfa"
        //DOCKER_REPO="599405637292.dkr.ecr.us-east-1.amazonaws.com/webapp"
        DOCKER_REPO="599405637292.dkr.ecr.us-west-1.amazonaws.com/webapp"
    }
    stages {
       stage('Checkout Git on Branch Parameter') {
          when {                
                expression { 
                     params.BRANCH != null
                }
          }
          steps {
              script {       
                git([url: env.GITURL, branch: env.BRANCH, credentialsId: env.CREDENTIALS])
              }
           }      
       }
       stage('Build WebApp Docker Image'){
          steps {
               script {
                  docker.build(env.DOCKER_REPO)
               }
          }   
       } 
       stage('Push and Pull Docker Image'){
          when {                
                expression { 
                     params.BRANCH!= null
                }
          }
          steps {
                script {
                    def version
                    sh "echo 01-dev-`git log --pretty=format:'%h' -n 1` > version"
                    version = readFile('version').trim()
                    //sh "eval \$(/usr/local/bin/aws ecr get-login --no-include-email --region us-east-1)"  
                    sh "eval \$(aws ecr get-login --no-include-email --region ${env.REGION2})"

                    sh "aws ecr describe-repositories --repository-names webapp --region ${env.REGION2}"
                    //sh "aws ecr delete-repository --force --repository-name webapp --region ${env.REGION2}"
                    
                    //sh "aws ecr create-repository --repository-name webapp --region ${env.REGION2}"
                    //docker.image(env.DOCKER_REPO).push(version).withRun('-p 3010:3000 -w /app/source/')
                    docker.image(env.DOCKER_REPO).push(version)
                }
         }
      }
      stage('Pull Docker Image'){
         when {                
                expression { 
                     params.BRANCH!= null
                }
          }
          steps {
                script {
                    //sh "eval \$(aws ecr get-login --no-include-email --region ${env.REGION2})"
                    //sh "docker run -it -p 3010:3000 -w /app/source/ "
                    //docker.image(env.DOCKER_REPO).push(version)
                    //docker.image(env.DOCKER_REPO).push(version).withRun('-p 3010:3000 -w /app/source/')
                    sh "docker run -p 3010:3000 -w /app/source/ 599405637292.dkr.ecr.us-west-1.amazonaws.com/webapp:01-dev-d9bdc37"
                }
         }

      }
    }

}
