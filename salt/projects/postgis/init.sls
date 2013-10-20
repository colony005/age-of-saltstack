postgis_template:
  cmd.script:
    - source: salt://projects/postgis/create_template_postgis-debian.sh
    - user: postgres
    - unless: psql -l | grep template_postgis
    - require:
      - pkg: postgresql
      - pkg: postgis_dependency


postgis_dependency:
  pkg.latest:
    - pkgs:
      - postgresql-9.1-postgis
      - libgeos-c1
      - libproj0
      - libgdal1

# Postgresql 9.1+ pouziva CREATE EXTENSION postgis;
# viz http://dj15.doc/ref/contrib/gis/install/postgis.html#creating-a-spatial-database-with-postgis-2-0-and-postgresql-9-1