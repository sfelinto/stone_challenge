# Stone DevOps - Sergio's Challenge

## Getting Started
This Git Repository is designed to participate the challenge of Stone's company for DevOps position

### Tools and technologies used

- [ ] Jenkins
- [ ] AWS Cloudformation
- [ ] AWS ECS - Elastic Container Service
- [ ] Docker
- [ ] NodeJs

### Deployment

- [ ] Deploy it the Jenkins within the AWS Cloudformation using the **deploy-jenkins-stone.yml** file:
    - This file has the infrastructure that is necessary for Jenkins running.
    - It's necessary create a keypar that used when run the Jenkins script.
    - After cloudformation script is created, the DNS of loader balancer will be the URL of Jenkins.
    - The Jenkins' password was changed in cloudformation script .
    - It's necessary manualy configuring AWS resources on the Jenkins.

- [ ] Using the Jenkins pipeline to deploy the AWS ECS Cluster within the AWS Cloudformation using the **deploy-cluster-stone.yml** file;
    - This script will create ECS cluster and network resources and instances are necessary for running the stone site;
    - And push/pull the Site Image to ECS Repository;

- [ ] Using the Jenkins pipeline to deploy the Site within the AWS Cloudformation using the **deploy-site-stone.yml** file;
    - This script will configure the AWS ECS Task and Service that running our site and publish on web.
    - The site must being accessed using the ECS Cluster Load Balancer URL.
    
## Authors

* **Sergio Felinto** - *Initial work* - [Sfelinto](https://github.com/sfelinto/stone_challenge)