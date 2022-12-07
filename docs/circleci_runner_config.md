## CIRCLE CI Self-hosted Runner config on VM

Do this on the VM to configure the self-hosted runner of Circle CI on the VM

[NOTE]: You must have self-hosted runner on Circle CI and have its API AUTH KEY.
### Setup Docker and update system
```
sudo apt-get update
sudo apt-get upgrade -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo systemctl status docker
```
### To install docker compose
```
sudo apt install docker-compose
```

### Add cloud user to docker group
```
sudo usermod -aG docker <<username>>
newgrp docker
```
### Download the launch agent binary and verify the checksum
```
mkdir configurations
cd configurations
curl https://raw.githubusercontent.com/CircleCI-Public/runner-installation-files/main/download-launch-agent.sh > download-launch-agent.sh
export platform=linux/amd64 && sh ./download-launch-agent.sh
```

### Create the circleci user & working directory
```
id -u circleci &>/dev/null || sudo adduser --disabled-password --gecos GECOS circleci
sudo mkdir -p /var/opt/circleci
sudo chmod 0750 /var/opt/circleci
sudo chown -R circleci /var/opt/circleci /opt/circleci/circleci-launch-agent
```

### Create a CircleCI runner configuration
```
sudo mkdir -p /etc/opt/circleci
sudo touch /etc/opt/circleci/launch-agent-config.yaml
sudo nano /etc/opt/circleci/launch-agent-config.yaml
```
### Add API in the file and change permissions
```
api:
    auth_token: AUTH_TOKEN

runner:
    name: RUNNER_NAME
    working_directory: /var/opt/circleci/workdir
    cleanup_working_directory: true
```
```
sudo chown circleci: /etc/opt/circleci/launch-agent-config.yaml
sudo chmod 600 /etc/opt/circleci/launch-agent-config.yaml
```

### Enable the systemd unit
```
sudo touch /usr/lib/systemd/system/circleci.service
sudo nano /usr/lib/systemd/system/circleci.service
```
#### Put Content in the circleci.service
```
[Unit]
    Description=CircleCI Runner
    After=network.target
[Service]
    ExecStart=/opt/circleci/circleci-launch-agent --config /etc/opt/circleci/launch-agent-config.yaml
    Restart=always
    User=circleci
    NotifyAccess=exec
    TimeoutStopSec=18300
[Install]
    WantedBy = multi-user.target
```
```    
sudo chown root: /usr/lib/systemd/system/circleci.service
sudo chmod 644 /usr/lib/systemd/system/circleci.service
```

### Start CircleCI
```
sudo systemctl enable circleci.service
sudo systemctl start circleci.service
```

### Add circleci to sudo group
```
sudo usermod -aG docker circleci
newgrp docker
```

### Setup Google Cloud
```
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-409.0.0-linux-x86_64.tar.gz
tar -xf google-cloud-cli-409.0.0-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh --path-update true
```