{# Pubkeys for system accounts #}
ssh_keys_granted:
  root: ['euclides']

{# Revoked pubkeys for non-active accounts #}
ssh_keys_revoked:
  root: ['hanibal']


{# List of projects, eg. virtual hosts #}
projects:
  hanging_gardens:
    root_path: /var/www/hanging-gardens.ago/
    user: hanging
    group: garden
    ssh_keys: ['democritos']

    {# the name of django project app #}
    project_app: hanging

    vcs: local

    environments:
      staging:
        python: python2.7
        {# git branch to checkout #}
        branch: staging
        {# django settings module #}
        settings: hanging.settings.staging
        database:
          user: hanging
          password: ***
          name: hanging
          template: template_postgis
        webserver:
          enabled: True
          {# where to server this app #}
          hosts:
            - dev.hanging-gardens.ago
            - hanging-gardens.dev
          {# type of wsgi, uwsgi is only supported right now #}
          wsgi: uwsgi

      production:
        python: python2.7
        branch: production
        settings: hanging.settings.production
        database:
          user: hanging
          password: ***
          name: hanging
          template: template_postgis
        webserver:
          enabled: True
          hosts:
            - hanging-gardens.ago
          wsgi: uwsgi
