

```
#file:/etc/systemd/system/sentinel-server.service
#pip3 install sentinel-server

[Unit]
Description=Sentinel Sentry Service

[Service]
Type=simple
Restart=always
User=root
Group=root
WorkingDirectory=/usr/libexec/sentinel
ExecStart=/usr/bin/python3 -m sentinel_server sentry

[Install]
WantedBy=multi-user.target
```

