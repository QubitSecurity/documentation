# Repo
for local

## 1. Install

### 1.1 Install

    dnf -y install yum-utils createrepo
            
### 1.2 Create directories for repository

    mkdir -p /var/www/repos/rocky/8/x86_64/os
    
    chmod -R 755 /var/www/repos

### 1.3 copy from official repository

    reposync -p /var/www/repos/rocky/8/x86_64/os/ --repo=baseos --download-metadata
    
    reposync -p /var/www/repos/rocky/8/x86_64/os/ --repo=appstream --download-metadata
    
    reposync -p /var/www/repos/rocky/8/x86_64/os/ --repo=extras --download-metadata
    
### 1.4 create repodata

    createrepo /var/www/repos/rocky/8/x86_64/os/appstream/
    
    createrepo /var/www/repos/rocky/8/x86_64/os/baseos/
    
    createrepo /var/www/repos/rocky/8/x86_64/os/extras/

### 1.5 update repodata

    createrepo --update /var/www/repos/rocky/8/x86_64/os/appstream/
    
    createrepo --update /var/www/repos/rocky/8/x86_64/os/baseos/
    
    createrepo --update /var/www/repos/rocky/8/x86_64/os/extras/

### 1.4 selinux

    restorecon -r /var/www/repos/

### 1.5 setting rules to firewalld

    firewall-cmd --add-service=httpd --permanent
    
    firewall-cmd --reload

### 1.6 testing

    dnf repolist

    dnf module list

## 2. EPEL

### 2.1 Create directories for repository

    mkdir -p /var/www/repos/rocky/epel/8/Everything/x86_64/
    
    chmod -R 755 /var/www/repos

### 2.2 copy from official repository

    reposync -p /var/www/repos/rocky/epel/8/Everything/x86_64/ --repo=epel --download-metadata
    
### 2.3 create repodata

    createrepo /var/www/repos/rocky/epel/8/Everything/x86_64/

### 2.4 update repodata

    createrepo --update /var/www/repos/rocky/epel/8/Everything/x86_64/

### 2.4 testing

    dnf list xrdp

## 3. dnf localinstall

### 3.1 create repodata

    dnf -y install yum-utils

### 3.2 make directory

    mkdir ~/packages

### 3.3 examples
    
    yumdownloader nfs-utils --downloadonly --resolve --downloaddir ~/packages/

### 3.4 example with remmina
    
    yumdownloader remmina --downloadonly --resolve --downloaddir ~/packages/remmina

### 3.5 install with remmina
    
    dnf localinstall avahi-ui-gtk3-0.7-20.el8.x86_64.rpm libappindicator-gtk3-12.10.0-19.el8.x86_64.rpm libdbusmenu-16.04.0-12.el8.x86_64.rpm libdbusmenu-gtk3-16.04.0-12.el8.x86_64.rpm libindicator-gtk3-12.10.1-14.el8.x86_64.rpm libsodium-1.0.18-2.el8.x86_64.rpm remmina-1.4.32-1.el8.x86_64.rpm remmina-plugins-exec-1.4.32-1.el8.x86_64.rpm remmina-plugins-rdp-1.4.32-1.el8.x86_64.rpm remmina-plugins-secret-1.4.32-1.el8.x86_64.rpm remmina-plugins-vnc-1.4.32-1.el8.x86_64.rpm
