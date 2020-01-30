FROM wordpress:5.3.2-php7.3-apache
ARG WWWDATA_UID
ARG WWWDATA_GID
ARG WWWHOST
RUN usermod -u ${WWWDATA_UID} www-data
RUN groupmod -g ${WWWDATA_GID} www-data
RUN apt-get -y update && apt-get -y install mariadb-client awscli mailutils
RUN mkdir -p /wpmultienv
RUN echo ${WWWHOST} > /wpmultienv/wwwhost
ADD ./publish.sh /wpmultienv/publish.sh
ADD ./deploy.sh /wpmultienv/deploy.sh
RUN chmod 755 /wpmultienv/publish.sh /wpmultienv/deploy.sh
