base:
  '*':
    - requirements.essential
    - ssh
    - system
  'vagrant.django-salted.org':
    - example-project.requirements
    - example-project.nginx
    - example-project.rabbitmq-server
    - example-project.redis
    - example-project.share
    - example-project.venv
    - example-project.uwsgi
    - example-project.postgresql
    - example-project.celery
