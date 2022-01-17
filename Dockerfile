FROM ubuntu:18.04

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN apt-get -qq update && apt-get -qq install -y --no-install-recommends \
    git python3 python3-pip \
    locales python3-lxml aria2 \
    curl wget pv jq nginx npm && \
    locale-gen en_US.UTF-8 && \
    curl https://git.io/gclone.sh && bash gclone.sh && \
    curl https://github.com/mawaya/rclone/releases/download/fclone-v0.4.1/fclone-v0.4.1-linux-amd64.zip && \
    unzip fclone-v0.4.1-linux-amd64.zip && mv fclone-v0.4.1-linux-amd64/fclone /usr/bin/ && chmod +x /usr/bin/fclone && rm -r fclone-v0.4.1-linux-amd64
    wget https://raw.githubusercontent.com/smartass08/telegram_gcloner/master/requirements.txt && \
    pip3 install --no-cache-dir -r requirements.txt && \
    rm requirements.txt && \
    apt-get -yqq purge git && \
    apt-get -y autoremove --purge && rm -rf /var/lib/apt/lists/* && apt-get -y clean

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY . .
RUN chmod +x start.sh 
CMD ["bash", "start.sh"]
