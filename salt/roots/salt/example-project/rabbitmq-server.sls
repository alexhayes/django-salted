include:
  - rabbitmq-server

vhost_{{ pillar['rabbitmq-server']['vhost'] }}:
  rabbitmq_vhost.present:
    - name: {{ pillar['rabbitmq-server']['vhost'] }}
    - require:
      - pkg: rabbitmq-server

user_{{ pillar['rabbitmq-server']['user'] }}:
  rabbitmq_user.present:
    - name: {{ pillar['rabbitmq-server']['user'] }}
    - password: {{ pillar['rabbitmq-server']['password'] }}
    - force: True
    - tags:
      - user
    - perms:
      - {{ pillar['rabbitmq-server']['vhost'] }}:
        - '.*'
        - '.*'
        - '.*'
    - require:
      - pkg: rabbitmq-server

admin_user_{{ pillar['rabbitmq-server']['admin_user'] }}:
  rabbitmq_user.present:
    - name: {{ pillar['rabbitmq-server']['admin_user'] }}
    - password: {{ pillar['rabbitmq-server']['admin_password'] }}
    - force: True
    - tags:
      - administrator
      - user
    - perms:
      - '/':
        - '.*'
        - '.*'
        - '.*'
      - {{ pillar['rabbitmq-server']['vhost'] }}:
        - '.*'
        - '.*'
        - '.*'
    - require:
      - pkg: rabbitmq-server

# Remove the guest user
guest:
  rabbitmq_user.absent:
    - require:
      - pkg: rabbitmq-server