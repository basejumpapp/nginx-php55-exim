### Dockerfile
#
# BaseJump PHP5.5 PHP-FPM and NGINX with Exim MTA

FROM basejump/nginx-php55
MAINTAINER Devon Weller <dweller@atlasworks.com>

# install exim
RUN yum -y install exim

# add custom exim.conf
ADD exim.conf /etc/mail/exim.conf

# restart exim service once
RUN service exim restart

# add new supervisd conf file with exim
ADD supervisord.conf /etc/



