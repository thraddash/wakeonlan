#!/bin/bash
set -e

echo "=====> Install ethtool and wakeonlan ==========================>"
echo "=====> Press enter to continue or Press q to quit =============>"
read TS
if [[ $TS == "q" ]]; then
  exit
else [[ $TS == "" ]];
  apt install ethtool wakeonlan
fi

echo
echo "##################################################################"
echo "=====> Create wol_fix script /etc/network/if-up.d/wol_fix =======>"
echo "=====> Press enter to continue or Press q to quit ===============>"
read TS
if [[ $TS == "q" ]]; then
  exit
else [[ $TS == "" ]];
  network_interface=$(ip route get 8.8.8.8 | awk -- '{printf $5}')
  cat > /etc/network/if-up.d/wol_fix <<EOF
#!/bin/bash
ethtool -s $network_interface wol g
EOF

echo "=====> cat /etc/network/if-up.d/wol_fix ========================>"
cat /etc/network/if-up.d/wol_fix
echo
echo "=====> chmod 755 wol_fix and execute script ====================>"
chmod 755 /etc/network/if-up.d/wol_fix
/etc/network/if-up.d/wol_fix
fi