FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive \
    LANG en_US.UTF-8 \
    LANGUAGE en_US:en \
    LC_ALL en_US.UTF-8

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN apt-get -qq update && apt-get -qq install -y --no-install-recommends \
    git python3 python3-pip \
    locales python3-lxml aria2 \
    curl wget unzip pv jq nginx npm && \
    locale-gen en_US.UTF-8 && \
    curl https://git.io/gclone.sh | bash && \
    mv /usr/bin/gclone /usr/src/app/ && chmod +x /usr/src/app/gclone && \
    wget https://raw.githubusercontent.com/smartass08/telegram_gcloner/master/requirements.txt && \
    pip3 install --no-cache-dir -r requirements.txt && \
    rm requirements.txt && \
    apt-get -yqq purge git && \
    apt-get -y autoremove && rm -rf /var/lib/apt/lists/* && apt-get -y clean

COPY . .
RUN chmod +x start.sh 
CMD ["bash", "start.sh"]
