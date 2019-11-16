import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.10
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import ".."

Gauge {
  minimumValue: 100
  maximumValue: 300
  value: 50
  height: 100;
  width: 50;

  minorTickmarkCount: 0

  tickmarkStepSize: 50


}
