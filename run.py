import sys
from PyQt5 import QtWidgets
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, QThread
from PyQt5.QtGui import QTextObject
from PyQt5 import QtCore
import random
from functools import partial
import re
import time
import obd



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
        self.time = QtCore.QDateTime.currentDateTime().toString("h:mm ap")

    # Configuration values

    @QtCore.pyqtProperty(QtCore.QVariant, notify=configChanged)
    def config(self):
        return QtCore.QVariant(self.m_config)

    @config.setter
    def config(self, val):
        self.m_config.update(val)
        self.configChanged.emit(self.m_config)


    # @QtCore.pyqtProperty(QtCore.QVariant, notify=diagnosticsChanged)
    # def diagnostics(self):
    #     return QtCore.QVariant(self.m_diagnostics)
    #
    # @handler.setter
    # def diagnostics(self, val):
    #     self.m_diagnostics.update(val)
    #     self.diagnosticsChanged.emit(self.m_diagnostics)






    # @QtCore.pyqtProperty(int, notify=rpmValueChanged)
    # def rpmValue(self):
    #     return self.m_rpmValue
    #
    # @rpmValue.setter
    # def rpmValue(self, val):
    #     if self.m_rpmValue == val:
    #         return
    #     self.m_rpmValue = val
    #     self.rpmValueChanged.emit(val)
    #
    # @QtCore.pyqtProperty(int, notify=speedValueChanged)
    # def speedValue(self):
    #     return self.m_speedValue
    #
    # @speedValue.setter
    # def speedValue(self, val):
    #     if self.m_speedValue == val:
    #         return
    #     self.m_speedValue = val
    #     self.speedValueChanged.emit(val)
    #
    # @QtCore.pyqtProperty(int, notify=tempValueChanged)
    # def tempValue(self):
    #     return self.m_tempValue
    #
    # @tempValue.setter
    # def tempValue(self, val):
    #     if self.m_tempValue == val:
    #         return
    #     self.m_tempValue = val
    #     self.tempValueChanged.emit(val)

mc = Main_Context()

class Obd_Thread(QThread):

    def __init__(self, mc):
        QThread.__init__(self, mc)
        self.mc = mc

    def __del__(self):
        self.wait()

    def set_rpm(self, r):
        if(r.value):
            # mc.rpmValue = re.findall('\d{3}', r.value)
            mc.handler = {'rpm': r.value.magnitude}
            # print(r.value.magnitude)

    def set_speed(self, r):
        if(r.value):
            mc.handler = {'speed': r.value.to("mph").magnitude}
            # mc.speedValue = r.value.to("mph").magnitude
            # print(r.value.magnitude)
    def set_temp(self, r):
        if(r.value):
            # mc.tempValue = r.value.to('degF').magnitude
            mc.handler = {'engine_temp': r.value.to('degF').magnitude}



    def run(self):
        # OBD lib setup
        port = obd.scan_serial()

        connection = obd.Async(fast=True, timeout=0.5)
        connection.watch(obd.commands.RPM, callback=self.set_rpm)
        connection.watch(obd.commands.SPEED, callback=self.set_speed)
        connection.watch(obd.commands.COOLANT_TEMP, callback=self.set_temp)
        command_list = connection.supported_commands

        for command in command_list:
                if(command is not None):
                    print(command)
                # ret = connection.query(command)
                # print(ret)
            # mc.handler = {command.name: ret.value.magnitude}

        # for i in range(len(command_list)):
        #     print(list(command_list)[i])

        connection.start()



def click_handle():
    print("button clicked\n")


def getFromFile():
    f = open("output.txt", "r")
    if f.mode == 'r':
        contents = f.readlines()

    int_arr = []

    for str in contents:
        num = re.findall('\d{3}', str)
        if num:
            int_arr.append(int(num[0]))

    return int_arr




def main():

    app = QtWidgets.QApplication(sys.argv)
    ex = QQmlApplicationEngine()
    ctx = ex.rootContext()
    # mc = Main_Context()
    ctx.setContextProperty("main", mc)

    #int_arr = getFromFile()

    mc.handler = {'rpm': 1000}
    mc.handler = {'speed': 50}
    mc.handler = {'engine_temp': 240}

    mc.config = {'style': 'dark'}



    ex.load('run.qml')

    win = ex.rootObjects()[0]

    # Timer for current time
    timer = QtCore.QTimer()
    timer.setInterval(1000)
    timer.timeout.connect(mc.updateTime)
    timer.start()

    m_obdThread = Obd_Thread(mc)
    m_obdThread.start()


    #
    # timer = QtCore.QTimer()
    # timer.setInterval(1000)
    # timer.timeout.connect(mc.run_speed)
    # timer.start()

    # for val in int_arr:
    #     mc.rpmValue = val
    #     app.processEvents()
    #     time.sleep(.5)


    win.show()
    sys.exit(app.exec_())




if __name__ == '__main__':
    main()
