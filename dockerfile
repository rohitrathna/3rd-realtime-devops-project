FROM centos:8

LABEL maintainer="vikash@gmail.com"

# Update and adjust yum repositories
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Update packages and install Java, httpd, and file utilities in one step
RUN yum -y update && \
    yum install -y java-1.8.0-openjdk httpd zip unzip

# Download and set up the website template
RUN wget -O /tmp/photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip && \
mv /tmp/photogenic.zip /var/www/html/


WORKDIR /var/www/html/

RUN unzip -q "*.zip" && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Expose port 80 and run Apache in the foreground
EXPOSE 80 22
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
