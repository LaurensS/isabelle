# Variant of docker makarius/isabelle without the entrypoint
FROM ubuntu:latest
# Set maintainer
LABEL maintainer="Laurens Sion <laurens@sion.info>"

# Set the working directory to /app
WORKDIR /data
VOLUME /data

# Update and install texlive-full
RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy curl less lib32stdc++6 libgomp1 libwww-perl rlwrap unzip wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    cd /var/opt/ && \
    wget http://isabelle.in.tum.de/dist/Isabelle2018_app.tar.gz && \
    tar -xzf Isabelle2018_app.tar.gz && \
    rm Isabelle2018_app.tar.gz && \
    mv Isabelle2018 Isabelle && \
    perl -pi -e 's,ISABELLE_HOME_USER=.*,ISABELLE_HOME_USER="\$USER_HOME/.isabelle",g;' Isabelle/etc/settings && \
    perl -pi -e 's,ISABELLE_LOGIC=.*,ISABELLE_LOGIC=HOL,g;' Isabelle/etc/settings && \
    Isabelle/bin/isabelle build -s -b HOL && \
    ln -s /var/opt/Isabelle/bin/isabelle /usr/bin/isabelle
