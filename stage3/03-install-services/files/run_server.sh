cd /home/example_user/firmware/testing/factory
source venv/bin/activate
cd factory_manager

export SENTRISENSE_TOKEN='SENTRI_TOKEN_EXAMPLE'
export EMNIFY_TOKEN='EMNIFY_TOKEN_EXAMPLE'

IP=$(ip -4 addr show wt0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

python manage.py makemigrations

python manage.py migrate --noinput

DJANGO_SUPERUSER_PASSWORD="DJANGO_SUPERUSER_PASSWORD_EXAMPLE"

python manage.py createsuperuser --noinput --username admin --email example_user@sentrisense.com

python manage.py runserver $IP:8000
