FROM valerianomanassero/java-centos:latest

MAINTAINER Valeriano Manassero valeriano.manassero@staff.aruba.it

RUN rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch
ADD elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
RUN yum -y install elasticsearch
RUN yum -y clean all
ADD logging.yml /etc/elasticsearch/logging.yml
RUN chown elasticsearch:elasticsearch /etc/elasticsearch/logging.yml

USER root
COPY docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh

USER elasticsearch
EXPOSE 9200
ENTRYPOINT ["/docker-entrypoint.sh"]