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
       stage('Push Docker Image'){
          when {                
                expression { 
                     params.BRANCH!= null
                }
          }
          steps {
                script {
                    def version
                    sh "echo 01-dev-1 `git log --pretty=format:'%h' -n 1` > version"
                    version = readFile('version').trim()
                    //sh "eval \$(/usr/local/bin/aws ecr get-login --no-include-email --region us-east-1)"  
                    sh "eval \$(aws ecr get-login --no-include-email --region us-west-1)"
                    sh "docker tag sfelinto:stone_challenge 599405637292.dkr.ecr.us-west-1.amazonaws.com/webapp:version"
                    docker.image(env.DOCKER_REPO).push(version)
                }
         }
      }
      /*
      stage('Pull docker Image'){
         when {                
                expression { 
                     params.BRANCH!= null
                }
          }
          steps {
                script {
                    
                    sh "eval \$(/usr/local/bin/aws ecr get-login --no-include-email --region us-east-1)"
                    sh "docker run -it -p 3010:3000 -w /app/source/ env.DOCKER_REPO.push(01-dev-1)"
                    docker.image(env.DOCKER_REPO).push(version)
                }
         }

      }*/
    }

}
