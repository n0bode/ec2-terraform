#!/bin/bash

if [[ -e lib/systemd/system/webapp.service ]]; then
    echo "restarting service"
    systemctl restart webapp.service
    exit 0 
fi

echo "
[Unit]
Description=Uvicorn systemd service.
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
ExecStart=$(which uvicorn) app:app --port 80 --host 0.0.0.0
RuntimeDirectory=$(which uvicorn)
WorkingDirectory=$(pwd)
ExecReload=/bin/kill -s HUP $MAINPID
KillMode=mixed
TimeoutStopSec=5
PrivateTmp=true
RestartSec=1
Restart=always

[Install]
WantedBy=multi-user.target" > /lib/systemd/system/webapp.service

echo "enableding service"
systemctl enable webapp.service
echo "starting webapp"
systemctl start webapp.service 
