/tmp/delete_old_cluster.sh:
  cmd:
    - run
  file:
    - absent

postgresql_remove_packages:
  pkg.purged:
    - pkgs:
      - postgresql-9.2
      - postgresql-client-9.2