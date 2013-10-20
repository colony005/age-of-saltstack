{% if 'user' in env_settings %}
project_{{ project_label }}_{{ env_label }}_user:
  user:
    - present
    - name: {{ user }}
    - home: {{ project.root_path }}
    - shell: /bin/false
    - password: '!'
    - groups:
      - {{ project.group }}
{% endif %}