
alert icmp any any -> any any (msg:"ICMP Packet"; classtype:icmp-event; sid:477; rev:1;)


b'{"_SYSTEMD_UNIT":"snort.service","__CURSOR":"s=1f48ec9f702c4f47b1f3eb7f86f51836;i=46a1;b=a850218fc9aa405288bb34e936e4e11a;m=21442becf;t=5f5ddc774bfde;x=377691f4d3d8dddd","_MACHINE_ID":"c2a68eb4e3a7480b96ea85d7faf067c0","_SYSTEMD_SLICE":"system.slice","_EXE":"/usr/sbin/snort","PRIORITY":"1","_CMDLINE":"/usr/sbin/snort -m 027 -D -d -l /var/log/snort -u snort -g snort --pid-path /run/snort/ -c /etc/snort/snort.conf -i eth1","_CAP_EFFECTIVE":"0","_SYSTEMD_INVOCATION_ID":"74beb3a809ae4da0ad6981a75b6475e8","MESSAGE":"[1:527:8] BAD-TRAFFIC same SRC/DST [Classification: Potentially Bad Traffic] [Priority: 2] {IGMP} 0.0.0.0 -> 224.0.0.1","__MONOTONIC_TIMESTAMP":"8929853135","_BOOT_ID":"a850218fc9aa405288bb34e936e4e11a","__REALTIME_TIMESTAMP":"1677707766448094","_COMM":"snort","SYSLOG_PID":"17603","SYSLOG_IDENTIFIER":"snort","_HOSTNAME":"pi-store","_PID":"17603","_UID":"117","SYSLOG_FACILITY":"4","SYSLOG_TIMESTAMP":"Mar  1 21:56:06 ","_SOURCE_REALTIME_TIMESTAMP":"1677707766447992","_GID":"123","_TRANSPORT":"syslog","_SELINUX_CONTEXT":"unconfined\\n","_SYSTEMD_CGROUP":"/system.slice/snort.service"}\n'


b'{"_COMM":"snort","_SYSTEMD_CGROUP":"/system.slice/snort.service","SYSLOG_IDENTIFIER":"snort","__MONOTONIC_TIMESTAMP":"9057852870","_GID":"123","_CMDLINE":"/usr/sbin/snort -m 027 -D -d -l /var/log/snort -u snort -g snort --pid-path /run/snort/ -c /etc/snort/snort.conf -i eth1","_SELINUX_CONTEXT":"unconfined\\n","PRIORITY":"1","_EXE":"/usr/sbin/snort","_CAP_EFFECTIVE":"0","_SYSTEMD_UNIT":"snort.service","__CURSOR":"s=1f48ec9f702c4f47b1f3eb7f86f51836;i=46b2;b=a850218fc9aa405288bb34e936e4e11a;m=21be3ddc6;t=5f5ddcf15ded5;x=3003cc09ef70ff25","_MACHINE_ID":"c2a68eb4e3a7480b96ea85d7faf067c0","_HOSTNAME":"pi-store","SYSLOG_TIMESTAMP":"Mar  1 21:58:14 ","MESSAGE":"[1:527:8] BAD-TRAFFIC same SRC/DST [Classification: Potentially Bad Traffic] [Priority: 2] {IGMP} 0.0.0.0 -> 224.0.0.1","_SYSTEMD_INVOCATION_ID":"74beb3a809ae4da0ad6981a75b6475e8","_SOURCE_REALTIME_TIMESTAMP":"1677707894447729","SYSLOG_PID":"17603","_BOOT_ID":"a850218fc9aa405288bb34e936e4e11a","SYSLOG_FACILITY":"4","_TRANSPORT":"syslog","_PID":"17603","_SYSTEMD_SLICE":"system.slice","__REALTIME_TIMESTAMP":"1677707894447829","_UID":"117"}\n'


alert icmp any any -> any any (msg:"ICMP Packet"; classtype:icmp-event; sid:477; rev:1;)





sentinel update-config watch-syslog '{"config":"logstream","logfile":"stream","rules":["MESSAGE","SYSLOG_IDENTIFIER","PRIORITY","_CMDLINE","_EXE"]}'

sentinel update-rule rule-1-sort '{"config":"watch-syslog","match":[{"SYSLOG_IDENTIFIER":"snort"}],"expire":"30"}'






