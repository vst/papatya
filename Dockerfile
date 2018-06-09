## We want to use the latest LTS Ubuntu version 18.04:
FROM ubuntu:18.04

## Who is maintaining this?
MAINTAINER Vehbi Sinan Tunalioglu <vst@vsthost.com>

## Install /usr/local/share artifacts:
ADD install/papatya /usr/local/share/papatya

## Important Notes
## ===============
##
## 1. Number and Variety of Debian Packages Installed
## --------------------------------------------------
##
## Any image extending this very image will possibly need to install
## further software and/or R packages. It is not rare that an R
## package is compiled and linked against other system
## libraries. Therefore, this build file is not shying away from
## installing development tools and libraries.
##
## 2. rapache Installation Method
## ------------------------------
##
## There is a PPA which provides pre-compiled rapache module:
##
## https://launchpad.net/~opencpu/+archive/ubuntu/rapache
##
## However, it is not updated for a long time as of the preparation of
## this build script. Furthermore, there is no "bionic" (Ubuntu 18.04)
## release which breaks the build process.
##
## Therefore, the manual build and installation method is chosen for
## rapache.
##
## 3. Choice of Apache2 Multi-Processing Module
## --------------------------------------------
##
## Sadly, R is not a multi-threaded library by design. Although
## Apache2 comes with worker or event based options, this image sticks
## to prefork option to isolate requests from each other.
##
## TODO: Ensure that each HTTP request is well isolated and there are
## enough child processes to handle a reasonable number of requests.
##
## 4. rJava Installation Method
## ----------------------------
##
## We could well install it using the conventional method (via
## install.packages function). Yet, we want to stick to Debian
## conventions. But again, Ubuntu 18.04 comes with Java 11 and
## r-cran-rjava seems not to play well with it. Therefore, we are
## installing Java 8 and manually reconfiguring system Java
## alternative and re-running `R CMD javareconf`.
##
## TODO: Bug report and solution alternative for the above mentioned
## problem? Check https://github.com/s-u/rJava/issues/146

## Carry on with installation, configuration and clean-up procedure:
RUN echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections && \
    apt-get update              && \
    apt-get install --yes          \
        build-essential            \
        software-properties-common \
        devscripts                 \
        nano                       \
        curl                       \
        git                        \
        openjdk-8-jdk              \
        apache2                    \
        apache2-dev                \
        libapreq2-dev              \
        r-base-core                \
        r-base-dev                 \
        r-cran-devtools            \
        r-cran-rjava               \
        r-cran-markdown            \
        r-cran-knitr            && \
    update-java-alternatives -s java-1.8.0-openjdk-amd64                               && \
    R CMD javareconf                                                                   && \
    git clone https://github.com/jeffreyhorner/rapache /tmp/rapache                    && \
    cd /tmp/rapache && ./configure && make && make install && cd -                     && \
    cp /tmp/rapache/debian/mod_R.load /etc/apache2/mods-available                      && \
    a2dismod mpm_event                                                                 && \
    a2enmod mpm_prefork                                                                && \
    a2enmod mod_R                                                                      && \
    mkdir /app                                                                         && \
    mkdir /data                                                                        && \
    cp /usr/local/share/papatya/apache2/www/index.html /var/www/html/                  && \
    cp /usr/local/share/papatya/apache2/000-default.conf /etc/apache2/sites-available/ && \
    rm -rf /tmp/rapache                                                                && \
    apt-get clean

## Define the port to expose:
EXPOSE 80

## Define volumes:
VOLUME /app
VOLUME /data
VOLUME /usr/local/share/papatya/startup/custom
VOLUME /var/www/html

## Default command:
CMD apachectl -D FOREGROUND
