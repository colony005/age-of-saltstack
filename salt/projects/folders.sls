{% set layout = ['logs/nginx', 'logs/django',
                 'public/media', 'public/static'] %}

{# Set up project layout #}
{% for directory in layout %}
{{ env_root }}/{{ directory }}:
  file.directory:
    - user: {{ user }}
    - group: {{ project.group }}
    - file_mode: 644
    - dir_mode: 755
    - makedirs: True
    - require:
      {% if 'user' in env_settings %}
      - user: project_{{ project_label }}_{{ env_label }}_user
      {% endif %}
      - group: project_{{ project_label }}_group
{% endfor %}
