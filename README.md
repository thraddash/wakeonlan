# wakeonlan
create bash script and service to fix wake-on-lan being reset to disabled on shutdown

#### 1. Become root user
#### 2. Execute wol_script.sh
```
sudo su
./wol_script.sh
```

```
=====> Install ethtool and wakeonlan ==========================>
=====> Press enter to continue or Press q to quit =============>

Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
ethtool is already the newest version (1:5.9-1).
wakeonlan is already the newest version (0.41-12.1).
0 upgraded, 0 newly installed, 0 to remove and 96 not upgraded.

##################################################################
=====> Create wol_fix script /etc/network/if-up.d/wol_fix =======>
=====> Press enter to continue or Press q to quit ===============>

=====> cat /etc/network/if-up.d/wol_fix ========================>
#!/bin/bash
ethtool -s enp3s0 wol g

=====> chmod 755 wol_fix and execute script ====================>
```

#### 3. Execute wol_service.sh
```
./wol_service.sh
```

```
=====> Create /etc/systemd/system/wol_fix.service =============>

[Unit]
Description=Fix WakeOnLAN being reset to disabled on shutdown

[Service]
ExecStart=/etc/network/if-up.d/wol_fix
Type=oneshot
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target

#########################################################################
=====> Reload and Enable wol_fix.service ===============================>
=====> systemctl daemon-reload/ systemctl enable wol_fix.service =======>
=====> Press enter to continue or Press q to quit ======================>

######## Current status: wol_fix.service #############################
Active: active (exited) since Fri 2021-08-27 16:02:35 PDT; 1h 46min ago
```
