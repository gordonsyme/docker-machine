#!/bin/bash

set -exu

echo "bootstrapping"

UBUNTU_CODENAME=$(lsb_release --codename --short)

# Configure system
hostname dockerer


# Install keys


# Configure mirrors
apt-get update
apt-get install --yes python-software-properties

add-apt-repository --yes "deb http://ftp.heanet.ie/pub/ubuntu/ ${UBUNTU_CODENAME} main"
add-apt-repository --yes "deb mirror://mirrors.ubuntu.com/mirrors.txt ${UBUNTU_CODENAME} main restricted universe multiverse"
add-apt-repository --yes "deb mirror://mirrors.ubuntu.com/mirrors.txt ${UBUNTU_CODENAME}-updates main restricted universe multiverse"
add-apt-repository --yes "deb mirror://mirrors.ubuntu.com/mirrors.txt ${UBUNTU_CODENAME}-backports main restricted universe multiverse"
add-apt-repository --yes "deb mirror://mirrors.ubuntu.com/mirrors.txt ${UBUNTU_CODENAME}-security main restricted universe multiverse"


# Add software repos
apt-add-repository --yes ppa:andrei-pozolotin/maven3
add-apt-repository --yes ppa:webupd8team/java


# Set package install defaults
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections


# Install packages
apt-get update
apt-get install --quiet --yes \
  docker.io \
  oracle-java8-installer \
  oracle-java8-set-default \
  maven3 \
  git \
  socat \
  gnupg2 \
  pinentry-curses

apt-get remove --yes --purge command-not-found
apt-get autoremove --yes --purge

# Set up the vagrant user's bashrc
BASHRC=/home/vagrant/.bashrc

cat << _EOF >> ${BASHRC}
export PS1="[\u@\[\e[0;34m\]\h\[\e[0m\] \w]$ "
_EOF

# Configure services

echo "bootstrap finished"
