####################################
#  B.E.A.R Website Tracker  #
####################################

FROM kibana:6.4.2
USER root

LABEL maintainer="B.E.A.R. <bcakir@beartell.com>"

RUN yum install -y wget curl

# Kibana Configuration
COPY ./config/kibana.yml /usr/share/kibana/config/kibana.yml
# Plugins
COPY ./data/kibana-time-plugin.tar.gz /home/kibana-time-plugin.tar.gz
COPY ./data/datasweet_formula.tar.gz /home/datasweet_formula.tar.gz
COPY ./data/enhanced-table.tar.gz /home/enhanced-table.tar.gz
RUN cd /home/ && \
        tar xvf kibana-time-plugin.tar.gz && \
        tar xvf datasweet_formula.tar.gz && \
        tar xvf enhanced-table.tar.gz && \
        mv kibana-time-plugin /usr/share/kibana/plugins/kibana-time-plugin && \
        mv datasweet_formula /usr/share/kibana/plugins/datasweet_formula && \
        mv enhanced-table /usr/share/kibana/plugins/enhanced-table
RUN rm -rf /home/kibana-time-plugin.tar.gz
RUN rm -rf /home/datasweet_formula.tar.gz
RUN rm -rf /home/enhanced-table.tar.gz

# Dashboards
COPY ./data/saved_object.json /home/saved_objects.json

# Entrypoint
COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]