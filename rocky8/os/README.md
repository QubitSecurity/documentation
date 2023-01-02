# OS
rocky8

## 0. Disable IPv6

### 0.1 Edit grub

    vi /etc/default/grub
    
    ipv6.disable=1
    
    grub2-mkconfig -o /boot/grub2/grub.cfg

    reboot

## 1. Preconfig

### 1.1 Chronyd

    dnf -y install chrony
    
    vi /etc/chronyd.conf
    
    systemctl enable --now chronyd
            
### 1.2 Rsyslog

    dnf -y install rsyslog
    
    systemctl enable --now rsyslog
    
### 1.3 Snmp

    dnf -y install net-snmp net-snmp-utils
    
    vi /etc/snmpd/snmp.conf
    
    systemctl enable --now snmpd
    
    snmpwalk -v2c -c rocky8 localhost system
    
### 1.4.1 Zabbix Agent

    dnf -y install https://repo.zabbix.com/zabbix/6.3/rhel/8/x86_64/zabbix-release-6.3-1.el8.noarch.rpm
    
    dnf -y install zabbix-agent2
    
    vi /etc/zabbix/zabbix_agent2.conf
    
    systemctl enable --now zabbix-agent2

### 1.4.2 Zabbix Agent Selinux

    dnf install checkpolicy
    
    vi zabbix_agent.te
    
    setsebool -P domain_can_mmap_files on
    
    checkmodule -m -M -o zabbix_agent.mod zabbix_agent.te
    
    semodule_package --outfile zabbix_agent.pp --module zabbix_agent.mod
    
    semodule -i zabbix_agent.pp


## 2. Firewalld
    
### 2.1 all

    firewall-cmd --add-service=snmp --permanent
    
    firewall-cmd --add-port=10050/tcp --permanent
    
    firewall-cmd --reload
    
## 9. Check
    
### 9.1 systemd-tmpfiles-setup.service

    systemctl status systemd-tmpfiles-setup.service