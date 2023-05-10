FROM ghcr.io/gap-system/gap-docker:master

LABEL maintainer="Zachariah (Zach) Newbery <zachariah.newbery@gmail.com>"

# Update version number each time after gap-docker container is updated
ENV GAP_VERSION 4.11.1

# Remove previous typeset installation, copy this repository and make new install
WORKDIR /home/gap/inst/gap-${GAP_VERSION}/pkg
RUN rm -rf typeset \
    && wget https://github.com/ZachNewbery/typeset/archive/main.zip \
    && unzip -q main.zip \
    && rm main.zip \
    && mv typeset-main typeset \
    && cp -R typeset/demo/custom ~/.jupyter 

USER gap

WORKDIR /home/gap/inst/gap-${GAP_VERSION}/pkg/typeset/demo
