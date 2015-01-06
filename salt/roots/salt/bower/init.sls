npm:
  pkg.installed

# Ensure node works on Ubuntu - see http://stackoverflow.com/a/20845072/3216868
node-alternative:
  alternatives.install:
    - name: node
    - link: /usr/bin/node
    - path: /usr/bin/nodejs
    - priority: 10
    - require:
      - pkg: npm

bower:
  npm.installed:
    - require:
      - pkg: npm