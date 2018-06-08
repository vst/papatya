## We want to use the latest stable Debian (and slim please):
FROM debian:stretch-slim

## Who is maintaining this?
MAINTAINER Vehbi Sinan Tunalioglu <vst@vsthost.com>

## Carry on with the base installation procedure:
RUN echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections && \
    apt-get update && \
    apt-get install -y --no-install-recommends nano curl devscripts git apache2 apache2-dev libapreq2-dev r-base-dev && \
    git clone https://github.com/jeffreyhorner/rapache /tmp/rapache && \
    cd /tmp/rapache && \
    ./configure && \
    make && \
    make install && \
    cp debian/mod_R.load /etc/apache2/mods-available && \
    a2enmod mod_R && \
    cd - && \
    rm -Rf /tmp/rapache && \
    apt-get clean

## Add installation artifacts:
ADD install /tmp/install

## Continue with installation:
RUN cp /tmp/install/index.html /var/www/html/ && \
    cp /tmp/install/000-default.conf /etc/apache2/sites-available/

## Define the port to expose:
EXPOSE 80

## Default command:
CMD apachectl -D FOREGROUND
