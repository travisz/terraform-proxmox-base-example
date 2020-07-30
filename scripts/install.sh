# Docker / Kubernetes Installation

# Clean up some old stuff on the install image
# Sleep is due to some initial tasks running after boot
sleep 20
sudo /usr/bin/rm -fv /etc/apt/sources.list.d/deb_debian_org_debian.list

sudo apt-get update
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    vim
