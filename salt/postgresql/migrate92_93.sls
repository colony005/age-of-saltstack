postgresql_stopped:
  service.dead:
    - name: postgresql

postgresql_disabled_auth:
  file.sed:
    - name: /etc/postgresql/9.2/main/pg_hba.conf
    - before: md5
    - after: 'trust #upgrade'
    - require:
      - service: postgresql_stopped

postgresql93_change_ports:
  file.sed:
    - name: /etc/postgresql/9.3/main/postgresql.conf
    - before: 5433
    - after:  5432
    - limit: ^port =
    - require:
      - cmd: postgresql_upgrade_92_to_93
      - service: postgresql_stopped

postgresql92_change_ports:
  file.sed:
    - name: /etc/postgresql/9.2/main/postgresql.conf
    - before: 5432
    - after:  5433
    - limit: ^port =
    - require:
      - cmd: postgresql_upgrade_92_to_93
      - service: postgresql_stopped

postgresql_upgrade_92_to_93:
  cmd.run:
    - cwd: /tmp
    - name: /usr/lib/postgresql/9.3/bin/pg_upgrade --check
                -d /var/lib/postgresql/9.2/main
                -D /var/lib/postgresql/9.3/main
                -b /usr/lib/postgresql/9.2/bin
                -B /usr/lib/postgresql/9.3/bin
                -o ' -c config_file=/etc/postgresql/9.2/main/postgresql.conf'
                -O ' -c config_file=/etc/postgresql/9.3/main/postgresql.conf'
    - user: postgres
    - require:
      - service: postgresql_stopped
      - file: postgresql_disabled_auth

postgresql_running:
  service.running:
    - name: postgresql
    - require:
      - cmd: postgresql_upgrade_92_to_93
      - file: postgresql92_change_ports
      - file: postgresql93_change_ports

postgresql_run_scripts:
  cmd.run:
    - cwd: /tmp
    - name: /tmp/analyze_new_cluster.sh
    - user: postgres
    - require:
      - cmd: postgresql_upgrade_92_to_93
      - service: postgresql_running

  file.absent:
    - name: /tmp/analyze_new_cluster.sh
    - require:
      - cmd: postgresql_upgrade_92_to_93
      - service: postgresql_running

postgresql_enable_auth:
  file.sed:
    - name: /etc/postgresql/9.2/main/pg_hba.conf
    - after: md5
    - before: 'trust #upgrade'
    - require:
      - cmd: postgresql_upgrade_92_to_93