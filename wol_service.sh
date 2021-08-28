set -e

echo "=====> Create /etc/systemd/system/wol_fix.service =============>"
echo "=====> Press enter to continue or Press q to quit =============>"
read TS
if [[ $TS == "q" ]]; then
  exit
else [[ $TS == "" ]];
  cat > /etc/systemd/system/wol_fix.service <<EOF
[Unit]
Description=Fix WakeOnLAN being reset to disabled on shutdown

[Service]
ExecStart=/etc/network/if-up.d/wol_fix
Type=oneshot
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
fi
cat /etc/systemd/system/wol_fix.service
echo
echo "#########################################################################"
echo "=====> Reload and Enable wol_fix.service ===============================>"
echo "=====> systemctl daemon-reload/ systemctl enable wol_fix.service =======>"
echo "=====> Press enter to continue or Press q to quit ======================>"
read TS
if [[ $TS == "q" ]]; then
  exit
else [[ $TS == "" ]];
  systemctl daemon-reload
  systemclt start wol_fix.service
  systemctl enable wol_fix.service
  echo "######## Current status: wol_fix.service #############################"
  echo $(systemctl status wol_fix.service| grep Active)
fi