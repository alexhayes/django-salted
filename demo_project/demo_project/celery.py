from __future__ import absolute_import
import os
from celery import Celery
from django.conf import settings
from datetime import datetime

# set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'demo_project.settings')

app = Celery('demo_project')

# Using a string here means the worker will not have to
# pickle the object when using Windows.
app.config_from_object('django.conf:settings')
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS, 'tasks')
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS, 'models')

@app.task
def ping():
    return datetime.now()