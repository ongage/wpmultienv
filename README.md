# wpmultienv - Wordpress Multi Environment
Allows multiple Wordpress environments on a single server or on multiple servers with quick deployments between environments and tracked versions backed in AWS S3. \
https://github.com/lupujo/wpmultienv

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
* Make sure to configure all settings properly into config file (wpmultienv.conf) per comments and make sure to generate strong *different* passwords for all password fields in config file.
* Use a firewall or a security policy to limit access to selected IPs (if desired) for the SFTP port (TCP/2222), Host SSH port (TCP/22) and the HTTP ports (TCP/80, TCP/443).
* If you need less than 3 ENVs, simply comment out or remove the unneccessary wordpress and db containers from docker-compose.yml. Keep the removed env(s) config variables in order to not break any script.
* Run init.sh before first launch from the project folder.
* Launch by running ```docker-compose up -d``` from the project folder.
* It's highly recommended to block web access to /wp-admin in the production environment and only use wp-admin under development environments.
* Optional: Create robots.txt-dev (usually deny all) and robots.txt-prod (usually allow) in Wordpress webroot folder, those will be deployed automatically depending on environment.

# Deployment between environments:
The action of "Publish" exports the entire wordpress website to S3 and returns a tag that can be used in the future to deploy to other environments in the same server or in different servers. \
The action of "Deploy" overrides the local wordpress website with a version from S3 that was previously published.
* Publish from any env to S3 by running:
```docker exec <container_name> /wpmultienv/publish.sh```
* Deploy from S3 to any env by running:
```docker exec <container_name> /wpmultienv/deploy.sh <tag>```

_Examples:_

* Publish from env1 to S3:
```docker exec wordpress-env1 /wpmultienv/publish.sh```
* Deploy a tag to env2 from S3:
```docker exec wordpress-env2 /wpmultienv/deploy.sh <tag>```

# TODO
* Add support for HTTPS
* Add support to get deployment commands without SSH access (API? Web based panel?)
* Add support to view apache/php logs without SSH access
* Implement support for email notifications
* Add checkpoints to all scripts to catch for errors and report properly
