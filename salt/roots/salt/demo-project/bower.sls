include:
  - bower

bower-install:
  cmd.run:
    - name: bower install --config.interactive=false
    - cwd: {{ pillar['django']['path'] }}
    - user: {{ pillar['django']['user'] }}
    - group: {{ pillar['django']['group'] }}
    - require:
      - npm: bower