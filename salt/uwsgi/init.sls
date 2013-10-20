uwsgi:
  pip.installed


/etc/nginx/uwsgi_params:
  file.managed:
    - user: root
    - group: root
    - mode: 600
    - source: salt://uwsgi/uwsgi_params
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx