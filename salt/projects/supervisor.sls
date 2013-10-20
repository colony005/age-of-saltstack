project_{{ project_label }}_{{ env_label }}_supervisor_config:
  file.managed:
    - name: /etc/supervisor/conf.d/{{ project_label }}_{{ env_label }}.conf
    - source: salt://projects/config/supervisor_service.conf
    - template: jinja
    - context:
      project: {{ project_label }}
      environment: {{ env_label }}
      user: {{ user }}
      group: {{ project.group }}
      project_dir: {{ env_root }}
    - require:
      - pkg: supervisor


project_{{ project_label }}_{{ env_label }}_supervisor:
{% if env_settings.webserver.enabled %}
  supervisord.running:
    - watch:
      - file: project_{{ project_label }}_{{ env_label }}_supervisor_config
{% else %}
  supervisord.dead:
{% endif %}
    - name: {{ project_label }}_{{ env_label }}
