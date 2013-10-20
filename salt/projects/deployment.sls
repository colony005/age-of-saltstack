{% Restart WSGI when new code is pulled with git or apps upgraded by pip. %}
project_{{ project_label }}_{{ env_label }}_wsgi_restart:
  file.touch:
    - name: {{ env_root }}/site/{{ project.project_app }}/wsgi.py
    - watch:
      - pip: project_{{ project_label }}_{{ env_label }}_update_pip
      - git: project_{{ project_label }}_{{ env_label }}_deployment


{# Pull changes from git repository #}
project_{{ project_label }}_{{ env_label }}_deployment:
  git.latest:
    - name: {{ vcs_root }}
    - target: {{ site_root }}
    - rev: {{ env_settings.branch }}
    - always_fetch: True
    - user: {{ project.user }}

    {% if project.vcs == 'local' %}
    - require:
      - git: project_{{ project_label }}_git
    {% endif %}


{# Upgrade packages in virtual environment #}
project_{{ project_label }}_{{ env_label }}_update_pip:
  pip.installed:
    - requirements: {{ site_root }}/requirements.txt
    - bin_env: {{ venv_root }}/bin/pip
    - upgrade: True
    - require:
      - virtualenv: project_{{ project_label }}_{{ env_label }}_virtualenv
    - watch:
      - git: project_{{ project_label }}_{{ env_label }}_deployment


{# Run collectstatic, syncdb and migrate #}
{% for sync_command in ('collectstatic', 'syncdb', 'command') %}
project_{{ project_label }}_{{ env_label }}_{{ sync_command }}:
  module.wait:
    - name: django.{{ sync_command }}
    - settings_module: {{ env_settings.settings }}
    {% if sync_command == 'command' %}
    - command: migrate
    {% endif %}
    - bin_env: {{ venv_root }}
    - pythonpath: {{ site_root }}
    - watch:
      - git: project_{{ project_label }}_{{ env_label }}_deployment
    - require:
      - virtualenv: project_{{ project_label }}_{{ env_label }}_virtualenv
      {% if sync_command in ('syncdb',  'command') %}
      - postgres_database: project_{{ project_label }}_{{ env_label }}_database
      {% endif %}
      {% if sync_command == 'command' %}
      - module: project_{{ project_label }}_{{ env_label }}_syncdb
      {% endif %}
{% endfor %}
