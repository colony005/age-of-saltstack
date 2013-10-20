{% for project_label, project in pillar['projects'].items() %}
{% if project.vcs == 'local' %}
  {% set vcs_root = project.root_path + "/" + project_label + ".git" %}
{% else %}
  {% set vcs_root = project.vcs %}
{% endif %}

{% include "projects/users.sls" %}
{% include "projects/vcs.sls" %}


{{ project.root_path }}:
  file.directory:
    - user: {{ project.user }}
    - group: {{ project.group }}
    - require:
      - user: project_{{ project_label }}_user


{# projects can have several environments (staging, production) #}
{% for env_label, env_settings in project.environments.items() %}
{% set env_root = "/".join([project.root_path, env_label]) %}
{% set venv_root = env_root + "/env" %}
{% set site_root = env_root + "/site" %}
{% set user = project.user if 'user' not in env_settings else env_settings.user %}

{% include "projects/env_users.sls" %}
{% include "projects/folders.sls" %}
{% include "projects/database.sls" %}
{% include "projects/nginx.sls" %}
{% include "projects/supervisor.sls" %}

{% if env_settings.webserver.wsgi == 'uwsgi' %}
{% include "projects/uwsgi.sls" %}
{% endif %}

{% include "projects/deployment.sls" %}

{# virtualenv pro projekt/environment #}
project_{{ project_label }}_{{ env_label }}_virtualenv:
  virtualenv.managed:
    - name: {{ venv_root }}
    - python: /usr/bin/{{ env_settings.python }}
    - system_site_packages: True
    - runas: {{ user }}
    - require:
      - file: {{ project.root_path }}
      - pkg: python-packages

{% endfor %} {# environments #}
{% endfor %} {# projects #}
