# piProjects
Misc RaspberryPi projects

## All projects
### Secrets:
* Upload your ssh key to your pi else ansible will fail
* All roles have a copy of the same vault (temp until a golbal vault is created) - Update as necessary

  ```
  wifi_ssid: 'xxx' #wifi ssid
  wifi_psk: 'xxx' #wifi password
  dak_token: 'xxx' #your personal DAK url
  db_admin: 'xxx' #influx db admin username
  db_admin_pass: 'xxx' #influx db admin password
  gmail_address: 'xxx' #Gmail account to send messages
  gmail_pass: 'xxx' #Gmail account PW
  ```

---
## Grafana with Influx Datastore on RaspberryPi3
### Notes:
* Home setup for Grafana and InfluxDB on a raspberryPi3
* Tested on Stretch - NOOBS

### Usage:
* Update hosts with IP or Hostname under the [piGrafana]

  ```
  --ask-sudo-pass may be required if running reboot role due to your local setup
  ansible-playbook piMetrics_setup.yml --ask-vault-pass -i hosts
  ```

---
## DAK Digital Wall Mount Calendar on RaspberryPi3
### Notes:
* Tested on Stretch - NOOBS
* You will need a DAK account (free)
* You will need a gmail account & calendar (free)

### Usage:
* Update hosts with IP or Hostname under the [piCalendar]

  ```
  --ask-sudo-pass may be required if running reboot role due to your local setup
  ansible-playbook piCalendar_setup.yml --ask-vault-pass -i hosts
  ```

---
## Send email from RaspberryPi3
### Notes:
* Tested on Stretch - NOOBS

### Usage:
* Run on single hosts, no inventory group setup

  ```
  --ask-sudo-pass may be required if running reboot role due to your local setup
  ansible-playbook piMailer_setup.yml --ask-vault-pass -i hosts
  ```

* Send email message:

  ```
  echo "hello" | mail -s "Subject Hello" emailaddress@gmail.com
  ```

---
## Plex server on RaspberryPi3
### Notes:
* HTpi on a raspberryPi3 (not very powerful at transcoding)
* Tested on jessie - LITE
* post install URI = <ip>:32400/web/
& You will need a plex account (free)

### Usage:
* Update hosts with IP or Hostname under the [piplex]

  ```
  --ask-sudo-pass may be required if running reboot role due to your local setup
  ansible-playbook piPlex_setup.yml --ask-vault-pass -i hosts
  ```

---
---
# sources:
* Credit for these projects goes to the following: (I simply automated the pi setup)
* these walkthroughs were for older versions if raspbian, needed some modifications to with stretch.

```
DAK Wall mount
https://dakboard.com/blog/diy-wall-display/
```
```
Grafana with InfluxDB
https://github.com/fg2it/grafana-on-raspberry/wiki
https://www.circuits.dk/install-grafana-influxdb-raspberry/
```
