### Dockerfile
#
# BaseJump PHP5.5 PHP-FPM and NGINX with Exim MTA

FROM basejump/nginx-php55
MAINTAINER Devon Weller <dweller@atlasworks.com>

# install exim
RUN yum -y install exim

# add custom exim.conf
ADD exim.conf /etc/exim/exim.conf

# add custom exim startup script
ADD exim-ec2-start.sh /usr/local/sbin/exim-ec2-start.sh

# add new supervisd conf file with exim
ADD supervisord.conf /etc/

# create a log file for supervisord
RUN mkdir /var/log/supervisord


