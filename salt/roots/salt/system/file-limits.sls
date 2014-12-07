# Ensure we don't run out of file handles, default on Ubuntu is 1024 
/etc/pam.d/common-session:
  file:
    - append
    - text:
      - "# Ensure /etc/security/limits.conf is honoured - see http://askubuntu.com/questions/162229/how-do-i-increase-the-open-files-limit-for-a-non-root-user"
      - session required pam_limits.so

/etc/pam.d/common-session-noninteractive:
  file:
    - append
    - text:
      - "# Ensure /etc/security/limits.conf is honoured - see http://askubuntu.com/questions/162229/how-do-i-increase-the-open-files-limit-for-a-non-root-user"
      - session required pam_limits.so

fs.inotify.max_user_watches:
  sysctl.present:
    - value: 1048576

/etc/security/limits.d/99-vagrant.conf:
  file.managed:
    - source: salt://system/99-vagrant.conf
    - user: root
    - group: root
    - mode: 744