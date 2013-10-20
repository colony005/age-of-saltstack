{% set available_conf = '/etc/nginx/sites-available/' + project_label + '_' + env_label %}
{% set enabled_conf = '/etc/nginx/sites-enabled/' + project_label + '_' + env_label %}

project_{{ project_label }}_{{ env_label }}_nginx:
  file.managed:
    - name: {{ available_conf }}
    - source: salt://projects/config/nginx_site.conf
    - template: jinja
    - context:
      project_dir: {{ env_root }}
      hosts: {{ env_settings.webserver.hosts }}


project_{{ project_label }}_{{ env_label }}_nginx_symlink:
{% if env_settings.webserver.enabled %}
  file.symlink:
    - name: {{ enabled_conf }}
    - target: {{ available_conf }}
    - require:
      - pkg: nginx
      - file: project_{{ project_label }}_{{ env_label }}_nginx
      - supervisord: project_{{ project_label }}_{{ env_label }}_supervisor
{% else %}
  file.absent:
    - name: {{ enabled_conf }}
    - require:
      - file: project_{{ project_label }}_{{ env_label }}_nginx
{% endif %}
    - watch_in:
      - service: nginx