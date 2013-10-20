#postgresql-repository:
#  pkgrepo.managed:
#    - name: deb http://apt.postgresql.org/pub/repos/apt/ {{ grains['oscodename'] }}-pgdg main
#    - file: /etc/apt/sources.list.d/pgdg.list
#    - key_url: https://www.postgresql.org/media/keys/ACCC4CF8.asc
#    - require_in:
#      - pkg: postgresql

postgresql:
  pkg:
    - latest
  service:
    - running
    - enable: True
    - require:
      - pkg: postgresql

python-psycopg2:
  pkg.latest:
    - require:
      - pkg: python

python3-psycopg2:
  pkg.latest:
    - require:
      - pkg: python3
