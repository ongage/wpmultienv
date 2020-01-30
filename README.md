# wpmultienv - Wordpress Multi Environment
Allows multiple Wordpress environments in a single server or in multiple servers with quick deployments between environments and tracked versions backed in AWS S3. \
Created by lupujo (jonathan.l@ongage.com)

# Usage examples:
* A single server with 1 dev env and 1 prod env
* A single server with 2 dev envs and 1 prod env
* 2 servers: prod (with 1 prod env) and dev (with 3 dev envs)
* 4 servers: prod (with 1 prod env), dev1 (with 1 dev env), dev2 (1 dev env), dev3 (1 dev env)

# Setup instructions:
* Clone into /usr/local/wpmultienv (or any other location, update PROJFOLDER in config file)
* To modify Wordpress or PHP versions, update the Dockerfile under wp/
* Create an S3 bucket and IAM user. Use an IAM policy that denies ListBucket for extra security.
* Add an IP per each environment to be used, update A records accordingly. Multiple IPs on a single instance were tested to be working under AWS EC2 by using "Secondary IPs".
* Make sure to configure all settings in config file (.env).
* Make sure to use a firewall or security policy that limits access to selected IPs for web, sftp, ssh and any other needed port.
* If you don't need 3 ENVs, comment out or remove the unneccessary wordpress and db instances from docker-compose.yml.
* Run init.sh before first launch from project folder.
* Launch by running ```docker-compose up -d``` from project folder.
* It's highly recommended to block access to /wp-admin in the production environment and only use wp-admin under development environments.
* TODO: Add support for HTTPS
* TODO: Add support to get deployment commands without SSH access (API? Web based panel?)
* TODO: Add support to view apache/php logs without SSH access
* TODO: Implement support for email notifications
* TODO: Add checkpoints to all scripts to catch for errors and report properly

# Deployment instructions:
Publishing exports the entire wordpress website to S3 and returns a tag that can be used in the future to deploy to other environments in the same server or in different servers. Deploying overrides the local wordpress website with a version that was previously published to S3.
* Publish from any env to S3 by running:
```docker exec <container_name> /wpmultienv/publish.sh```
* Deploy from S3 to any env by running:
```docker exec <container_name> /wpmultienv/deploy.sh <tag>```

_Examples:_

* Publish from env1 to S3:
```docker exec wordpress-env1 /wpmultienv/publish.sh```
* Deploy a tag to env2 from S3:
```docker exec wordpress-env2 /wpmultienv/deploy.sh <tag>```
