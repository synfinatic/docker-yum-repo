FROM centos:7
MAINTAINER Diego Gutierrez <dgutierrez1287@gmail.com>

RUN yum -y install epel-release && \
    yum -y update && \
    yum -y install ruby gcc ruby-devel supervisor createrepo yum-utils nginx && \
    yum clean all
RUN gem install --no-document ffi:1.12.2 rb-inotify:0.9.10

RUN mkdir /repo /logs

ADD nginx.conf /etc/nginx/nginx.conf
ADD supervisord.conf /etc/supervisord.conf
ADD scan_repo.rb /
ADD startup.sh /

RUN chmod 755 /scan_repo.rb /startup.sh

EXPOSE 80
VOLUME /repo /logs

ENTRYPOINT ["/startup.sh"]
