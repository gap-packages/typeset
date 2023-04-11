FROM ghcr.io/gap-system/gap-docker:master

LABEL maintainer="Zachariah Newbery <zachariah.newbery@gmail.com>"

# Update version number each time after gap-docker container is updated
ENV GAP_VERSION 4.11.1

# Remove previous typeset installation, copy this repository and make new install
WORKDIR /home/gap/inst/gap-${GAP_VERSION}/pkg
RUN rm -rf typeset \
    && wget https://github.com/ZachNewbery/typeset/archive/demo.zip \
    && unzip -q demo.zip \
    && rm demo.zip \
    && mv typeset-demo typeset \
    && cp -R typeset/demos/custom ~/.jupyter 



USER gap

WORKDIR /home/gap/inst/gap-${GAP_VERSION}/pkg/typeset/demos
