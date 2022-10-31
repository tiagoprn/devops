"""
WSGI config for django_project project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.6/howto/deployment/wsgi/
"""

import os
import sys
import logging
import site

logger = logging.getLogger('')
logger.setLevel(logging.DEBUG)
handler = logging.StreamHandler(sys.stderr)
handler.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(levelname)-8s %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)

# Add the site-packages of the chosen virtualenv to work with
site.addsitedir('/project_virtualenv/lib/python2.7/site-packages')

# Calculates the path based on the location of the WSGI script.
project_root = '/path/to/django_project/django_project' 
sys.path.append(project_root)
# os.environ.setdefault("DJANGO_SETTINGS_MODULE", "django_project.settings")
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings")

# logs into the webserver log file (apache, nginx error_log)
logger.debug(">>> PROJECT ROOT: %s" % project_root)
logger.debug('-' * 80)
logger.debug(">>> SYS.PATH: %s" % repr(sys.path))
logger.debug(">>> DJANGO SETTINGS MODULE: %s" % os.environ.get("DJANGO_SETTINGS_MODULE"))

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
