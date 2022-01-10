if [[ -n $CONFIG_FILE_URL ]]; then
	wget -q $CONFIG_FILE_URL -O /usr/src/app/telegram_gcloner/config.ini
fi

npm install http-server -g
http-server -p $PORT &
python3 telegram_gcloner/telegram_gcloner.py
