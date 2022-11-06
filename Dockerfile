FROM centos:latest
LABEL maintainer="chrisgao64@gmail.com"
RUN yum install -y httpd \
    zip\
    unzip

ADD https://www.free-css.com/assets/files/free-css-templaces/download/page354/photogenic.zip /var/www/html
WORKDIR /var/www/html/
RUN unzip photogenic.zip
RUN cp -rvf photogenic/*
RUN rm -rf photogenic photogenic.zip
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80