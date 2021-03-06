
# Sentinel watch-syslog using expert rules

## Linux syslog (journalctl, json)

### distributed sparse logging

```
sentinel update-config watch-syslog-stream '{"config":"logstream","logfile":"stream","rules":["MESSAGE"]}'
```
```
sentinel update-rule rule-1 '{"config":"watch-syslog-stream","search":"Call Trace","ignorecase":"False","data":["MESSAGE"]}'
sentinel update-rule rule-2 '{"config":"watch-syslog-stream","search":"Out of memory","ignorecase":"False","data":["MESSAGE"]}'
sentinel update-rule rule-3 '{"config":"watch-syslog-stream","search":"Killed process","ignorecase":"False","data":["MESSAGE"]}'
sentinel update-rule rule-4 '{"config":"watch-syslog-stream","search":"error","data":["MESSAGE"]}'




sentinel update-rule rule-5 '{"config":"watch-syslog-stream","search":"error","data":["MESSAGE"],"not":["noerror"],"pass":["952ac1cce6fe8b80d9f75f3718bc1943ddb63241"]}'

```

---


```
sentinel update-config watch-syslog-stream '{"config":"logstream","logfile":"stream","rules":["MESSAGE","SYSLOG_IDENTIFIER","SYSLOG_FACILITY","PRIORITY","USER_UNIT","_TRANSPORT","_CMDLINE","_COMM","_EXE","_HOSTNAME"]}'
```
```
sentinel update-rule expert-rule-1 '{"config":"watch-syslog-stream","match":[{"SYSLOG_IDENTIFIER":"systemd-logind"},{"_COMM":"systemd-logind"},{"_EXE":"/lib/systemd/systemd-logind"},{"_CMDLINE":"/lib/systemd/systemd-logind"}]}'
```

---

new data structure  "expire":"3600", will set expire.  864000 is default expire

```
sentinel update-rule rule-X '{"config":"watch-syslog","search":"Error","ignorecase":"False","data":["eventMessage"],"expire":"3600"}'
```




