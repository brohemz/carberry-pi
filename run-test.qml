import QtQuick 2.11
import QtTest 1.0
import QtQuick.Controls 2.4
import "./items" as Items

TestCase {
  name: "RunTests"

  function test_diagnostics() {
    compare(2 + 2, 4, "2 + 2 = 4");
  }
}
