FROM docker.io/linkstackorg/linkstack:latest

USER root

RUN sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/httpd.conf && \
    sed -i 's/:80/:8080/g' /etc/apache2/httpd.conf

RUN mkdir -p /htdocs_backup && cp -a /htdocs/. /htdocs_backup/

ENTRYPOINT ["sh", "-c", "if [ ! -f /htdocs/index.php ]; then cp -a /htdocs_backup/. /htdocs/; fi; chown -R apache:apache /htdocs; exec docker-entrypoint.sh"]

USER apache:apache
EXPOSE 8080