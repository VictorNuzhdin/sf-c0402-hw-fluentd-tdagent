# sf-c0402-hw-fluentd-tdagent
For Skill Factory study project (C04, HW1)

<br>


### Quick Info

```bash
Демонстрационные примеры разработанные в рамках учебного проекта
для Инструмента сборки и доставки логов (log shipper) "Fluent/td-agent"

Разработка производится в суб-каталогах "tests"
Текушая/последняя версия конфигурации и результатов размещена в каталоге "current"

```
<br>

### Quick UserGuide

```bash
#01 :: get latest config version from local tests
$ ./_scripts/updateCurrent.sh 33
$ ls -1X current/

        configs
        logs
        README.md

#02 :: create output logs dir
$ sudo mkdir -p /opt/fluent/logs
$ sudo chown -R td-agent:td-agent /opt/fluent
$ sudo chmod 755 -R /opt/fluent
$ sudo ls -la /opt/fluent

        drwxr-xr-x 3 td-agent td-agent 4096 Oct 31 18:45 .
        drwxr-xr-x 2 td-agent td-agent 4096 Oct 31 18:45 logs

#03 :: copy current config
$ sudo systemctl stop td-agent
$ sudo cp /etc/td-agent/td-agent.conf /etc/td-agent/td-agent.conf.last
$ sudo rm -f /etc/td-agent/td-agent.conf
$ sudo cp current/configs/td-agent.conf /etc/td-agent/
$ sudo chown td-agent:td-agent /etc/td-agent/td-agent.conf

#04 :: restart service
$ sudo systemctl restart td-agent
$ sudo systemctl status td-agent | grep Active

        Active: active (running) ..

#05.1 :: tests on local host [srv.dotspace.ru[

$ curl -X POST -d 'json={"source": "srv", "message": "hello1 from srv"}' https://srv.dotspace.ru/logging/hosts.logs
$ curl -X POST -d 'json={"source": "srv", "message": "hello2 from srv"}' https://srv.dotspace.ru/logging/hosts.logs

#05.2 :: tests on remote host 1 [host1.dotspace.ru]

$ curl -X POST -d 'json={"source": "host1", "message": "hello1 from host1"}' https://srv.dotspace.ru/logging/hosts.logs
$ curl -X POST -d 'json={"source": "host1", "message": "hello2 from host1"}' https://srv.dotspace.ru/logging/hosts.logs

#05.3 :: tests on remote host 2 [host2.dotspace.ru]

$ curl -X POST -d 'json={"source": "host2", "message": "hello1 from host2"}' https://srv.dotspace.ru/logging/hosts.logs
$ curl -X POST -d 'json={"source": "host2", "message": "hello2 from host2"}' https://srv.dotspace.ru/logging/hosts.logs

#06 :: check result on local logging server with Fluent Service (messages from "srv" is IGNORED)
$ tree /opt/fluent/logs

        /opt/fluent/logs
        ├── host1
        │   └── host1.hosts.logs.20231102231800.json
        └── host2
            └── host2.hosts.logs.20231102231800.json

$ cat /opt/fluent/logs/host1/host1.hosts.logs.20231102231800.json

        {"source":"host1","message":"hello1 from host1","receiver":"srv","dt":"2023-11-02T23:18:07+0600"}
        {"source":"host1","message":"hello2 from host1","receiver":"srv","dt":"2023-11-02T23:18:12+0600"}

$ cat /opt/fluent/logs/host2/host2.hosts.logs.20231102231800.json

        {"source":"host2","message":"hello1 from host2","receiver":"srv","dt":"2023-11-02T23:18:18+0600"}
        {"source":"host2","message":"hello2 from host2","receiver":"srv","dt":"2023-11-02T23:18:21+0600"}

```
<br>

### Changelog

```bash
2023.10.28 :: Начало проекта: изучение предметной области, документации и примеров
2023.10.31 :: Реализована 1я версия конфигурации Fluent: test10
2023.11.01 :: Реализована 2я версия конфигурации Fluent: test21, test22
2023.11.02 :: Реализована 2я версия конфигурации Fluent: test31, test32, test33
2023.11.03 :: Оформление проекта и выгрузка на GitHub
```
<br>

### Results

Результат обработки входящих сообщений/запросов с помошью Fluent/td-agent (v3.3) <br>
![screen](_screens/screen_v33_result_1.png?raw=true)
<br>
![screen](_screens/screen_v33_result_2.png?raw=true)
<br>
![screen](_screens/screen_v33_result_3.png?raw=true)
<br>
![screen](_screens/screen_v33_result_4.png?raw=true)
<br>

[Все скриншоты](_screens)
<br>

----
