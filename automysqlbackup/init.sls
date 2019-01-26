/usr/sbin/automysqlbackup:
  file.managed:
    - mode: 775
    - source: salt://automysqlbackup/files/automysqlbackup

/etc/automysqlbackup/automysqlbackup.conf:
  file.managed:
    - makedirs: True
    - mode: 664
    - source: salt://automysqlbackup/files/automysqlbackup.conf
