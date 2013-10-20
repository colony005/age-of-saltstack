project_{{ project_label }}_user:
  user.present:
    - name: {{ project.user }}
    - home: {{ project.root_path }}
    - shell: /bin/zsh
    - password: '*'
    - groups:
      - sshlogin


project_{{ project_label }}_group:
  group.present:
    - name: {{ project.group }}


{{ project.user }}_zsh_init:
  file.touch:
    - name: {{ project.root_path }}/.zshrc
    - user: {{ project.user }}
    - group: {{ project.group }}
    - require:
      - file: {{ project.root_path }}


{% for pubkey in project.ssh_keys %}
{{ project.user }}_ssh_key:
  ssh_auth.present:
    - user: {{ project.user }}
    - source: salt://ssh/keys/{{ pubkey }}.pub
{% endfor %}