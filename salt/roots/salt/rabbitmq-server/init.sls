base:
  pkgrepo.managed:
    - name: deb http://www.rabbitmq.com/debian/ testing main
    - file: /etc/apt/sources.list.d/rabbitmq.list
    - key_url: http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
    - require_in:
      - pkg: rabbitmq-server

  pkg.latest:
    - name: rabbitmq-server
    - refresh: True

rabbitmq-server:  
  pkg.installed:
    - name: rabbitmq-server

enable_mgmt_plugin:
  cmd.run:
    - name: rabbitmq-plugins enable rabbitmq_management
    - user: root
    - require:
      - pkg: rabbitmq-server