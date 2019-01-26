/usr/sbin/automysqlbackup:
  file.managed:
    - mode: 775
    - source: salt://automysqlbackup/files/automysqlbackup

/etc/automysqlbackup/automysqlbackup.conf:
  file.managed:
    - makedirs: True
    - template: jinja
    - context: {{ salt['pillar.get']('automysqlbackup:config') }}
    - mode: 664
    - source: salt://automysqlbackup/files/automysqlbackup.conf

{% if salt['pillar.get']('automysqlbackup:config:backup_dir') is defined %}
{{ salt['pillar.get']('automysqlbackup:config:backup_dir') }}:
  file.directory:
    - make_dirs: True
{% endif %}

{% set cron = salt['pillar.get']('automysqlbackup:cron', '') %}
automysql_cron:
{% if salt['pillar.get']('automysqlbackup:cron:enabled', False)  %}
  cron.present:
    - name: /usr/sbin/automysqlbackup
    - user: u'{{ cron.user | default('root') }}'
    - minute: u'{{ cron.minute | default('*') }}'
    - hour: u'{{ cron.hour | default('*') }}'
    - daymonth: u'{{ cron.daymonth | default('*') }}'
    - month: u'{{ cron.month | default('*') }}'
    - dayweek: u'{{ cron.dayweek | default('*') }}'
{% else %}
  cron.absent:
    - name: /usr/sbin/automysqlbackup
{% endif %}