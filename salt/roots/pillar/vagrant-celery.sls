celery:
  workers:
    - name: celery.default.w01
      options:
        queues: celery
        loglevel: DEBUG
        hostname: celery.default.w01
        autoreload:
        events: 
  beat: True
