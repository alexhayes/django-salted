base:
  '*':
    - requirements.essential
    - ssh
    - system
  'vagrant.django-salted.org':
    - demo-project.requirements
    - demo-project.nginx
    - demo-project.rabbitmq-server
    - demo-project.redis
    - demo-project.share
    - demo-project.venv
    - demo-project.uwsgi
    - demo-project.postgresql
    - demo-project.celery
    - demo-project.bower
    