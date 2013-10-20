{% set dbtemplate = env_settings.database.template %}

project_{{ project_label }}_{{ env_label }}_database_user:
  postgres_user.present:
    - name: {{ env_settings.database.user }}
    - password: {{ env_settings.database.password }}
    - encrypted: True
    - superuser: False
    - createdb: False
    - createuser: False
    - user: postgres
    - require:
      - pkg: postgresql


project_{{ project_label }}_{{ env_label }}_database:
  postgres_database.present:
    - name: {{ env_settings.database.name }}
    - owner: {{ env_settings.database.user }}
    - user: postgres
    {% if dbtemplate %}
    - template: {{ dbtemplate }}
    {% endif %}

    - require:
      - postgres_user: project_{{ project_label }}_{{ env_label }}_database_user
      {% if dbtemplate == 'template_postgis' %}
      - cmd: postgis_template
      {% endif %}


{% if dbtemplate == 'template_postgis' %}
{% include "projects/postgis/init.sls" %}
{% endif %}
