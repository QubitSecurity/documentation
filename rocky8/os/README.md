# OS
rocky8

## 0. Preconfig

### 0.1 Disable IPv6

    vi /etc/default/grub
    
    ipv6.disable=1
    
    grub2-mkconfig -o /boot/grub2/grub.cfg

    reboot

### 0.2 Proxy

    vi /etc/profile.d/pproxy.sh 
    
    export http_proxy=http://172.16.10.20:3128
    export https_proxy=http://172.16.10.20:3128


### 0.3 cockpit

    systemctl enable --now cockpit.socket
    
    https://10.10.10.10:9090/
    
### 0.4 sudoers

    cp -f /etc/sudoers /etc/sudoers.bak
    
    awk 'NR==102{print "user        ALL=(ALL)       NOPASSWD: ALL"}104' /etc/sudoers.bak > /etc/sudoers
    
    cat /etc/sudoers | grep user
    

## 1. Basic config

### 1.0 packages

    dnf -y install wget net-tools telnet bind-utils zip unzip tar tcpdump lsof nc chrony
    
    dnf -y install policycoreutils-python-utils epel-release

### 1.1 Chrony

    dnf -y install chrony
    
    vi /etc/chrony.conf
    
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
    
### 2.2 specific public zone

    firewall-cmd --zone=public --list-all
    
    firewall-cmd --permanent --zone=public --add-interface=ens224
    
    firewall-cmd --reload

### 2.3 specific trusted zone

    firewall-cmd --zone=trusted --list-all
    
    firewall-cmd --permanent --zone=trusted --add-interface=ens192
    
    firewall-cmd --permanent --zone=trusted --add-service=ssh
    firewall-cmd --permanent --zone=trusted --add-service=smtp
    firewall-cmd --permanent --zone=trusted --add-service=cockpit
    firewall-cmd --permanent --zone=trusted --add-port=3389/tcp
    firewall-cmd --permanent --zone=trusted --add-port=10050/tcp
    
    firewall-cmd --reload

### 2.4 Rich rules

    firewall-cmd --zone=trusted --permanent --add-rich-rule='rule family="ipv4" source address="10.10.10.0/23" accept'
    
    firewall-cmd --reload

## 3. Ansible
    
### 3.1 Install

    dnf -y install epel-release
    
    dnf -y install python3 python3-pip
    
    pip3 install ansible
    
    ansible --version

### 3.2.1 Config

    vi /etc/ansible/ansible.cfg
    
    # 113 line
    forks=100
    
    # 320 line
    host_key_checking = False
    
### 3.2.2 Edit hosts

    vi /etc/ansible/hosts
    
    [target_servers]
    10.0.0.51
    10.0.0.52
    
### 3.2.3 Basic command
    
    ansible all --list-hosts
    
    ansible target_servers --list-hosts

### 3.3 Make and copy key
    
    ssh-keygen -t rsa
    
    ssh-copy-id root@10.0.0.51

## 9. Check
    
### 9.1 systemd-tmpfiles-setup.service

    systemctl status systemd-tmpfiles-setup.service


### 9.2 CPU core Counts

    grep -c processor /proc/cpuinfo
    
    grep "physical id" /proc/cpuinfo | sort -u
    
    grep "cpu cores" /proc/cpuinfo | tail -1

## X. Useful Links

- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_systems_using_the_rhel_8_web_console/configuring-the-web-console-listening-port_system-management-using-the-rhel-8-web-console
    
- https://www.lesstif.com/ws/firewalld-43844015.html

- https://faq.hostway.co.kr/Linux_ETC/7437

- https://mpjamong.tistory.com/16
- https://3sikkim.tistory.com/7
