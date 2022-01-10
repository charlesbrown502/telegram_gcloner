FROM ubuntu:18.04

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app
RUN apt-get -qq update && apt-get -qq install -y --no-install-recommends \
    git python3 python3-pip \
    locales python3-lxml aria2 \
    curl wget pv jq nginx npm && \
    locale-gen en_US.UTF-8 && \
    apt-get -qq purge git && \
    apt-get -y autoremove && rm -rf /var/lib/apt/lists/* && apt-get clean
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt && \
COPY . .
RUN chmod +x start.sh gclone 
CMD ["bash","start.sh"]
