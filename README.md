# sentinel  

```
./sentinel.py [option]
```

```
./sentinel.py --help   

    options:

        nmap-net net
        ping-net ip/net

        port-scan [ip/net] [level]
        list-nmaps
        nmap ip [level]
        del-nmap ip
        clear-nmaps

        vuln-scan [ip/net]
        list-vulns [id]
        del-vuln id
        clear-vulns
        check-vuln id
        email-vuln id

        arps
        manuf mac
        lsof port
        rdns ip [srv]
        myip

        udp ip port
        udpscan ip port
        tcp ip port

        list-macs
        update-manuf mac
        update-dns mac ip

        listening
        listening-detailed
        listening-details port
        listening-allowed
        listening-alerts
        listening-allow port
        listening-remove port

        established
        established-lsof
        established-rules
        established-rules-filter
        established-rule ALLOW|DENY proto laddr lport faddr fport
        established-alerts
        delete-established-rule rowid
        clear-established-rules

        list-ips
        update-ip ip data
        update-ip-item ip item value
        delete-ip-item ip item value
        del-ip ip
        clear-ips

        list-jobs
        list-jobs-running
        list-jobs-available
        run-job name
        update-job name data
        delete-job name
        clear-jobs

        list-configs
        update-config name data
        delete-config name
        clear-configs

        list-rules
        update-rule name data
        delete-rule name
        clear-rules

        list-reports
        update-report name data
        delete-report name
        clear-reports

        list-alerts
        delete-alert id
        run-alert name
        update-alert name data
        run-alert name
        clear-alerts

        list-fims
        list-fims-changed
        check-fim [name]
        b2sum-fim [name]
        b2sum /dir/file
        update-fim name data
        delete-fim id
        add-fim name /dir/file
        del-fim name /dir/file

        list-files
        add-file /dir/file
        del-file /dir/file
        fim-restore /dir/file [/dir/file]
        fim-diff
        clear-files

        file-type /dir/file

        av-scan dir|file
        list-avs

        list-proms

        list-proms-db
        update-prom-db name data
        clear-proms-db

        list-b2sums
        clear-b2sums

        list-sshwatch
        clear-sshwatch

        list-counts
        clear-counts

        list-training [id|tags tag]
        update-training tag json
        update-training-tag id tag
        delete-training id
        clear-training

        list-occurrence [name|-eq,-gt,-lt,-ne,-le,-ge num]
        delete-occurrence name
        copy-occurrence name
        clear-occurrence

        sample-logstream count
        mark-training tag
        mark-training-on name

        tail file
        logstream
        logstream-json
        logstream-keys
        run-create-db
        run-ps

        sentry

        ---

        config

                watch-syslog:
                    rules
                    sklearn naive_bayes.MultinomialNB
                            naive_bayes.BernoulliNB

                watch-resin-log
                watch-mariadb-audit-log
                watch-ssh


```

Linux package repo hosting https://gitlab.com/_pkg/sentinel  




