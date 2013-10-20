project_{{ project_label }}_{{ env_label }}_wsgi:
  file.managed:
    - name: {{ env_root }}/uwsgi.ini
    - source: salt://projects/config/uwsgi.ini
    - template: jinja
    - context:
      project_dir: {{ env_root }}
      project_app: {{ project.project_app }}
      project: {{ project_label }}
      environment: {{ env_label }}
      django_settings: {{ env_settings.settings }}
      user: {{ user }}
      group: {{ project.group }}

    {% if env_settings.webserver.enabled %}
    - watch_in:
      - supervisord: project_{{ project_label }}_{{ env_label }}_supervisor
    {% endif %}
    - require:
      - pip: uwsgi
      - git: project_{{ project_label }}_{{ env_label }}_deployment
