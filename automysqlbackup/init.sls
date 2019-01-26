/usr/sbin/automysqlbackup:
  file.managed:
    - mode: 775
    - source: salt://automysqlbackup/files/automysqlbackup

/etc/automysqlbackup/automysqlbackup.conf:
  file.managed:
    - makedirs: True
    - mode: 664
    - source: salt://automysqlbackup/files/automysqlbackup.conf
    - unless: test -f /etc/automysqlbackup/automysqlbackup.conf

{% if salt['pillar.get']('automysqlbackup', False) %}
automysqlbackup_config:
  ini.options_present:
    - name: etc/automysqlbackup/automysqlbackup.conf
    - separator: '='
    - sections:
        {%- for k,v in salt['pillar.get']('sshd_config',{}).items() %}
        {{ k }}: '{{ v }}'
        {%- endfor %}
{% endif %}