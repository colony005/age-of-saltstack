{# Granted keys. #}
{% for user, keys in salt['pillar.get']('ssh_keys_granted', {}).items() %}
{% for pubkey in keys %}

{{ user }}_ssh_key:
  ssh_auth:
    - present
    - user: {{ user }}
    - source: salt://ssh/keys/{{ pubkey }}.pub
{% endfor %}{% endfor %}


{# Revoked keys #}
{# Isn't supported in Salt Stack right now #}
{# https://github.com/saltstack/salt/issues/3817 #}
{% for user, keys in salt['pillar.get']('ssh_keys_revoked', {}).items() %}
{% for pubkey in keys %}

{{ user }}_ssh_key_deny:
  ssh_auth:
    - absent
    - user: {{ user }}
    - source: salt://ssh/keys/{{ pubkey }}.pub
{% endfor %}{% endfor %}


ssh:
  service:
    - running
    - reload: True
    - watch:
      - file: /etc/ssh/sshd_config
    - require:
      - group: sshlogin


/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/config/sshd_config
    - template: jinja
    - user: root
    - group: root
    - mode: 400


sshlogin:
  group.present


root:
  user.present:
    - groups:
      - sshlogin
  require:
    - group: sshlogin
