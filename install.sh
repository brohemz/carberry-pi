#!/bin/bash

PACKAGES= "qml Python3-pyqt5 Python3-pyqt5.qtquick Qml-module-qtquick* Python3-setuptools"

sudo apt-get install "$PACKAGES" 

export CARLOC=`pwd`/src/
