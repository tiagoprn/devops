# Create django project using uv (inside the current directory):

```bash

uv init --no-package --python 3.14 --name dkards  # "dkards" is the project name here
uv add django
uv add --dev pytest pytest-django
uv run django-admin startproject dkards .  # the convention is to also use the project name here ("dkards")
uv run python manage.py migrate
# edit settings.py file and add the hostname to "ALLOWED_HOSTS" so that other apps are then able to access it from the network
uv run python manage.py runserver 0.0.0.0:8000

```

