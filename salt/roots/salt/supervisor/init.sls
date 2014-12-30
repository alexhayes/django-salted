# It appears that the Ubuntu supervisor creates /etc/supervisor/supervisord.conf 
# but supervisor expects /etc/supervisord.conf
# The following ensures that installation of the Ubuntu package works.
/etc/supervisord.conf:
  file.symlink:
    - target: /etc/supervisor/supervisord.conf

# Use system package so that we have start scripts etc..
supervisor:
  pkg:
    - installed
  watch:
    - file: /etc/supervisor/conf.d-enabled/*.conf
    - file: /etc/supervisor/supervisord.conf
  require:
    - file: /etc/supervisord.conf

# Upgrade using pip
upgrade_supervisor:
  cmd.run:
    - name: 'pip install supervisor --upgrade'
    - unless: test -e /usr/local/bin/supervisord
    - require:
      - pkg: supervisor

/usr/bin/supervisord:
  file.symlink:
    - target: /usr/local/bin/supervisord
    - require:
      - cmd: upgrade_supervisor

/etc/supervisor/conf.d-available:
  file.rename:
    - source: /etc/supervisor/conf.d
    - require:
      - cmd: upgrade_supervisor

/etc/supervisor/conf.d-enabled:
  file.directory:
    - user: root
    - group: root
    - makedirs: true
    - mode: 644
    - require:
      - cmd: upgrade_supervisor
      
# Rather than using conf.d/*.conf for includes, be more debian like and use conf.d-enabled/*.conf 
/etc/supervisor/supervisord.conf:
  file.replace:
    - pattern: |
        files = .*\.conf
    - repl: |
        files = /etc/supervisor/conf.d-enabled/*.conf
    - require:
      - cmd: upgrade_supervisor
