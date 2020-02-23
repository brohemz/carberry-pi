from PyQt5.QtCore import QObject, QThread
from PyQt5 import QtCore
import time
import sys

class Main_Context(QObject):
    # Refactor with Dictionary (State) - Done*
    # rpmValueChanged = QtCore.pyqtSignal(int)
    # speedValueChanged = QtCore.pyqtSignal(int)
    # tempValueChanged = QtCore.pyqtSignal(int)
    handlerChanged = QtCore.pyqtSignal(QtCore.QVariant)
    diagnosticsChanged = QtCore.pyqtSignal(QtCore.QVariant)
    timeChanged = QtCore.pyqtSignal(str)
    configChanged = QtCore.pyqtSignal(QtCore.QVariant)

    counter = 0


    def __init__(self, parent=None):
        super(Main_Context, self).__init__(parent)
        # self.m_rpmValue = 1
        # self.m_speedValue = 0
        # self.m_tempValue = 0
        self.m_handler = {}
        self.m_diagnostics = {}
        self.m_time = QtCore.QDateTime.currentDateTime().toString("h:mm ap")
        self.m_config = {}





    # Handler for main dashboard
    @QtCore.pyqtProperty(QtCore.QVariant, notify=handlerChanged)
    def handler(self):
        return QtCore.QVariant(self.m_handler);

    @handler.setter
    def handler(self, val):
        self.m_handler.update(val)
        self.handlerChanged.emit(self.m_handler);

    def getHandler(self):
        return self.m_handler

    # Current time in seconds

    @QtCore.pyqtProperty(str, notify=timeChanged)
    def time(self):
        return self.m_time

    @time.setter
    def time(self, val):
        if self.m_time == val:
            return
        self.m_time = val;
        self.timeChanged.emit(self.m_time);

    def updateTime(self):

        # self.time =
        # QtCore.QLocale.setDefault(QtCore.QLocale("en_DE"))
        self.time = QtCore.QDateTime.currentDateTime().toString("h:mm ap")

    # Configuration values

    @QtCore.pyqtProperty(QtCore.QVariant, notify=configChanged)
    def config(self):
        return QtCore.QVariant(self.m_config)

    def getConfig(self):
        return self.m_config

    @config.setter
    def config(self, val):
        self.m_config.update(val)
        self.configChanged.emit(self.m_config)

    @QtCore.pyqtSlot(QtCore.QVariant, QtCore.QVariant)
    def updateConfigFromQML(self, key, value):


        if value.lower() == "true":
            value = True
        elif value.lower() == "false":
            value = False

        updatedDict= self.getConfig()[key]
        updatedDict['current'] = value
        # print({key : updatedDict})
        self.config = {key : updatedDict}
        # print(self.getConfig())


    def close(val):
        sys.exit(val)


    @QtCore.pyqtProperty(QtCore.QVariant, notify=diagnosticsChanged)
    def diagnostics(self):
        return QtCore.QVariant(self.m_diagnostics)

    @diagnostics.setter
    def diagnostics(self, val):
        self.m_diagnostics.update(val)
        self.diagnosticsChanged.emit(self.m_diagnostics)

    def getDiagnostics(self):
        return self.m_diagnostics
