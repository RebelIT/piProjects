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
* Tested on Stretch

### Usage:
* Update hosts with IP or Hostname under the [piGrafana]

  ```
  --ask-sudo-pass may be required if running reboot role due to your local setup
  ansible-playbook piMetrics_setup.yml --ask-vault-pass -i hosts
  ```

---
## DAK Digital Wall Mount Calendar on RaspberryPi3
### Notes:
* Tested on Stretch

### Usage:
* Update hosts with IP or Hostname under the [piCalendar]

  ```
  --ask-sudo-pass may be required if running reboot role due to your local setup
  ansible-playbook piCalendar_setup.yml --ask-vault-pass -i hosts
  ```

---
## Send email from RaspberryPi3
### Notes:
* Tested on Stretch

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
