

sentinel update-job port-scan-1 '{"time": "2020-09-20 00:00:00", "job": "port-scan", "ips": ["192.168.0.1/24"]}'

./sentinel.py update-job port-scan-1 '{"time": "2020-09-20 00:00:00", "job": "port-scan", "ips": ["192.168.0.1"]}'

sentinel update-job port-scan-repeat5min '{"repeat": "5min", "job": "port-scan", "ips": ["192.168.3.1/24"]}'

#level 2 needs root...
./sentinel.py update-job port-scan-level2 '{"time": "2020-09-20 00:00:00", "job": "port-scan2", "ips": ["192.168.0.1"]}'


