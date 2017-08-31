#!/bin/bash

# Пример bash project_install.sh git@src.direktline.ru

user=root
email=mail@mail.com
pass=root
repo=$1

git clone "$repo"


# Настройка virtualenv
basename=$(basename $repo)
filename=${basename%.*}
cd $filename
virtualenv -p python3 venv
source venv/bin/activate
pip3 install -r requirements/dev.txt


# Файл настроек dev.py
echo "from .dev_common import *

EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
# EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'

PIPELINE['PIPELINE_ENABLED'] = False

DOMAIN = '127.0.0.1'
SESSION_COOKIE_DOMAIN = DOMAIN
CSRF_COOKIE_DOMAIN = DOMAIN
ALLOWED_HOSTS = (
    DOMAIN,
    'localhost',
    '127.0.0.1',
)

DATABASES.update({
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': '$filename',
        'USER': 'project',
        'PASSWORD': 'password',
        'HOST': 'localhost',
    }
})
" >> src/settings/dev.py

# База данных
sudo su - postgres -c "/usr/bin/createdb -O project $filename"	
sudo su - postgres -c "echo \"alter user project with password 'password';\" | psql $filename"

source venv/bin/activate
python3 src/manage.py migrate
python3 src/manage.py collectstatic --noi
expect -c "
spawn python3 src/manage.py createsuperuser;
expect Username: ; 
send \"$user\r\" ;
expect address: ;
send \"$email\r\" ;
expect Password: ;
send \"$pass\r\" ;
expect (again): ;
send \"$pass\r\"
expect eof"
google-chrome 127.0.0.1:8001
python3 src/manage.py runserver 0.0.0.0:8001
