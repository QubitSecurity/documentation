## 1. Solr




## 2. Solr

### 2.1 Add-field-type

```
# cat /etc/selinux/targeted/contexts/users/sysadm_u 
system_r:local_login_t:s0       sysadm_r:sysadm_t:s0
system_r:remote_login_t:s0      sysadm_r:sysadm_t:s0
system_r:sshd_t:s0              sysadm_r:sysadm_t:s0
system_r:crond_t:s0             sysadm_r:sysadm_t:s0
system_r:xdm_t:s0               sysadm_r:sysadm_t:s0
sysadm_r:sysadm_su_t:s0         sysadm_r:sysadm_t:s0
sysadm_r:sysadm_sudo_t:s0               sysadm_r:sysadm_t:s0
system_r:initrc_su_t:s0         sysadm_r:sysadm_t:s0
sysadm_r:sysadm_t:s0            sysadm_r:sysadm_t:s0
sysadm_r:sysadm_su_t:s0         sysadm_r:sysadm_t:s0 
sysadm_r:sysadm_sudo_t:s0       sysadm_r:sysadm_t:s0
```
<hr/>
### 2.2 Replace-field

```
# cat /etc/selinux/targeted/contexts/users/unconfined_u 
system_r:crond_t:s0             unconfined_r:unconfined_t:s0
system_r:initrc_t:s0            unconfined_r:unconfined_t:s0
system_r:local_login_t:s0       unconfined_r:unconfined_t:s0
system_r:remote_login_t:s0      unconfined_r:unconfined_t:s0
system_r:rshd_t:s0              unconfined_r:unconfined_t:s0
system_r:sshd_t:s0              unconfined_r:unconfined_t:s0
system_r:sysadm_su_t:s0         unconfined_r:unconfined_t:s0
system_r:unconfined_t:s0        unconfined_r:unconfined_t:s0
system_r:initrc_su_t:s0         unconfined_r:unconfined_t:s0
unconfined_r:unconfined_t:s0    unconfined_r:unconfined_t:s0
system_r:xdm_t:s0               unconfined_r:unconfined_t:s0
```

<hr/>

```
a
```

<hr/>

```
b
```

<hr/>

```
c
```

<hr/>

```
d
```
