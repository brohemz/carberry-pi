import unittest
import run
from PyQt5 import QtWidgets
from PyQt5.QtQml import QQmlApplicationEngine
import sys
from context import Main_Context

mc_test = Main_Context

class AppTest(unittest.TestCase):

    # def __init__(self, arg):
    #     self.arg = arg
    #     print(self.arg + "wow")

    context = None

    def test_upper(self):
        self.assertEqual('foo'.upper(), 'FOO')

def main():
    app = QtWidgets.QApplication(sys.argv)
    ex = QQmlApplicationEngine()
    ctx = ex.rootContext()
    ctx.setContextProperty("main", mc_test)

    mc_test.handler = {'rpm': 1000}
    mc_test.handler = {'speed': 50}
    mc_test.handler = {'engine_temp': 240}

    mc_test.diagnostics = {'temp1': 200}
    mc_test.diagnostics = {'temp2': "wow"}
    mc_test.diagnostics = {'temp3': -14.2}

    ex.load('run-test.qml')

    sys.exit(app.exec_())

if __name__ == '__main__':
    # app = run.main()
    # AppTest.context = run.mc
    # unittest.main()
    main()
