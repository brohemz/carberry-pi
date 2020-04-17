#!/bin/bash
#
# File: install.sh
# Description: Bash executable for setting up all dependencies
# Project: Carberry Pi
# Author: Ryan McHugh
# Year: 2020
#

sudo apt-get install qml python3-pyqt5 python3-pyqt5.qtquick qml-module-qtquick* python3-setuptools python3-pip

pip3 install obd

sudo echo "export CARLOC=`pwd`/src/" >> ~/.bashrc

sudo echo "@/usr/bin/bash `pwd`/src/start_carberry.sh" >> "/etc/xdg/lxsession/LXDE/autostart"
