include:
  - redis.server

# Ensure our django user can read/write to the redis unix socket
redis-socket-access:
  user.present:
    - name: {{ pillar['django']['user'] }}
    - groups:
      - redis
    - remove_groups: False
    - require:
      - sls: redis.server