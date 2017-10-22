#!/bin/bash

cd /root/

pip install -r requirements.txt

cd auth-api/auth_api/

python manage.py migrate --noinput

python manage.py collectstatic --noinput

env > /etc/enviroment

supervisord -n