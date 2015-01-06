include:
  - nginx

example-nginx-conf:
  file.managed:
    - name: /etc/nginx/sites-available/{{ pillar['nginx']['server_name'] }}.conf
    - source: salt://demo-project/nginx.conf
    - template: jinja
    - user: www-data
    - group: www-data
    - mode: 755
    - require:
      - pkg: nginx

# Symlink and thus enable the virtual host
example-enable-nginx:
  file.symlink:
    - name: /etc/nginx/sites-enabled/{{ pillar['nginx']['server_name'] }}.conf
    - target: /etc/nginx/sites-available/{{ pillar['nginx']['server_name'] }}.conf
    - force: false
    - require:
      - file: example-nginx-conf