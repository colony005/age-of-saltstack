vagrant:
  user.present:
    - groups:
      - sshlogin
  require:
    - group: sshlogin