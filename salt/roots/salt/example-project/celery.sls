include:
  - supervisor

/var/run/demo_project:
  file.directory:
    - user: vagrant
    - group: vagrant
    - makedirs: True

{{ pillar['django']['log_path'] }}:
  file.directory:
    - user: vagrant
    - group: vagrant
    - makedirs: True

/etc/supervisor/conf.d-available/demo_project-celery.conf:
  file.managed:
    - source: salt://example-project/celery.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: supervisor

# Symlink and thus enable the celery.conf
/etc/supervisor/conf.d-enabled/demo_project-celery.conf:
  file.symlink:
    - target: /etc/supervisor/conf.d-available/demo_project-celery.conf
    - force: false
    - require:
      - file: /etc/supervisor/conf.d-available/demo_project-celery.conf