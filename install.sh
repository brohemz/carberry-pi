#!/bin/bash
#
# File: install.sh
# Description: Bash executable for setting up all dependencies
# Project: Carberry Pi
# Author: Ryan McHugh
# Year: 2020
#

PACKAGES= "qml Python3-pyqt5 Python3-pyqt5.qtquick Qml-module-qtquick* Python3-setuptools"

sudo apt-get install "$PACKAGES" 

sudo echo "export CARLOC=`pwd`/src/" >> ./bashrc
