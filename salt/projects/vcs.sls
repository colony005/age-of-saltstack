{% if project.vcs == 'local' %}
project_{{ project_label }}_git:
  git.present:
    - name: {{ vcs_root }}
    - user: {{ project.user }}
    - require:
      - file: {{ project.root_path }}
{% endif %}