FROM ubuntu:18.04
LABEL maintainer="v.stone@163.com" \
      organization="Truth & Insurance Office"

ADD https://ftp.mozilla.org/pub/mozilla.org/webtools/bugzilla-5.0.6.tar.gz /bugzilla.tar.gz
COPY ./bugzilla.conf /bugzilla.conf
COPY ./start-bugzilla /usr/bin/start-bugzilla

RUN apt update && \
    apt install -y gcc make apache2 libpq-dev curl && \
    mv /bugzilla.conf /etc/apache2/sites-available/bugzilla.conf && \
    tar zvxf /bugzilla.tar.gz && \
    rm -rf /bugzilla.tar.gz && \
    mv /bugzilla-5.0.6 /var/www/html/bugzilla && \
    a2ensite bugzilla && \
    a2enmod cgi headers expires && \
    service apache2 restart && \
    cd /var/www/html/bugzilla && \
    perl install-module.pl --all && \
    ./checksetup.pl && \
    perl install-module.pl DBD::Pg && \
    apt remove -y gcc make && \
    chmod +x /usr/bin/start-bugzilla

WORKDIR /var/www/html/bugzilla

CMD 'start-bugzilla'
