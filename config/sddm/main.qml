Row {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 20
    spacing: 24

    // Shutdown
    Item {
        width: 32; height: 32
        Image {
            anchors.fill: parent
            source: "shutdown.svgz"
            fillMode: Image.PreserveAspectFit
        }
        MouseArea {
            anchors.fill: parent
            onClicked: sddm.powerOff()
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }

    // Reboot
    Item {
        width: 32; height: 32
        Image {
            anchors.fill: parent
            source: "reboot.svgz"
            fillMode: Image.PreserveAspectFit
        }
        MouseArea {
            anchors.fill: parent
            onClicked: sddm.reboot()
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }

    // Suspend
    Item {
        width: 32; height: 32
        Image {
            anchors.fill: parent
            source: "suspend.svgz"
            fillMode: Image.PreserveAspectFit
        }
        MouseArea {
            anchors.fill: parent
            onClicked: sddm.suspend()
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }
}
