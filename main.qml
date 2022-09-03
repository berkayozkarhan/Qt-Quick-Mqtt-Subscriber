import QtQuick
import QtQuick.Controls 2.5
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Mqtt Client")

    Connections{
        target: MqttWorker
        onClient_connected : {
            console.log("mqtt client connected triggered.")
            lblMqttConnectedStatus.text = "True"
        }
        onClient_disconnected : {
            console.log("mqtt client disconnected triggered.")
            lblMqttConnectedStatus.text = "False"
            lblMqttsubscribedStatus.text = "False"
            lblMqttTopic.text = "Not subscribed."
        }
        onClient_subscribed : {
            console.log("topic : " + topic)
            lblMqttTopic.text = topic
            lblMqttsubscribedStatus.text = "True"
        }
        onClient_message_received : function(message, chg){
            lblData.text = chg.toString() + " : "
            lblValue.text = message.toString();
        }
    }

    Row{
        width:640
        height: 7
        id: rowTop
        Rectangle{
            width: 7
            height: 7
            color: "red"
        }
        Rectangle{
            width: parent.width - 14
            height: 7
            color: "red"
        }
        Rectangle{
            width: 7
            height: 7
            color: "red"
        }
    }
    Row{
        width: 640
        height: parent.height - 14
        id: rowMiddle
        anchors.top: rowTop.bottom
        Rectangle{
            width: 7
            height: parent.height
            color: "red"
        }
        Rectangle{
            width: parent.width - 14
            height: parent.height
            color: "green"

            Row{
                id: topRow
                width: parent.width
                height: parent.height / 5
                spacing: 7
                Item {
                    width: 70
                    height: parent.height
                }
                Column{
                    height: parent.height
                    Label{
                        text: "Connected:"
                        anchors.right: parent.right
                    }
                }
                Column{
                    height: parent.height
                    Label{
                        id: lblMqttConnectedStatus
                        text: "False"
                        anchors.right: parent.right
                    }
                }
                Item {
                    width: 50
                    height: parent.height
                }
                Column{
                    height: parent.height
                    Label{
                        text: "Subscribed:"
                    }
                }
                Column{
                    height: parent.height
                    Label{
                        id: lblMqttsubscribedStatus
                        text: "False"
                    }
                }
                Item {
                    width: 50
                    height: parent.height
                }
                Column{
                    height: parent.height
                    Label{
                        text: "Topic:"
                    }
                }
                Column{
                    height: parent.height
                    Label{
                        id: lblMqttTopic
                        text: ""
                    }
                }
            }

            Row{
                id: middleRow
                anchors.top: topRow.bottom
                width: parent.width
                height: parent.height * 2 / 5
                Column{
                    width: parent.width / 2
                    height: parent.height
                    Label{
                        id: lblData
                        text: "Data : "
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 37
                    }
                }
                Column{
                    width: parent.width / 2
                    height: parent.height
                    Label{
                        id: lblValue
                        text: "Value"
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 37
                    }
                }
            }
            Row{
                id: bottomRow
                anchors.top: middleRow.bottom
                width: parent.width
                height: parent.height * 2 / 5
                Column{
                    width: parent.width / 2
                    height: parent.height
                    Button{
                        id: btnStart
                        text: "Start"
                        width: parent.width
                        height: parent.height
                        font.pixelSize: 37
                        onClicked: {
                            MqttWorker.start()
                            btnStart.enabled = false
                            btnStop.enabled = true
                        }
                    }
                }
                Column{

                    width: parent.width / 2
                    height: parent.height
                    Button{
                        id: btnStop
                        text: "Stop"
                        width: parent.width
                        height: parent.height
                        font.pixelSize: 37
                        enabled: false
                        onClicked: {
                            MqttWorker.stop()
                            btnStart.enabled = true
                            btnStop.enabled = false
                        }
                    }
                }
            }


        }
        Rectangle{
            width: 7
            height: parent.height
            color: "red"
        }
    }
    Row{
        id: rowBottom
        anchors.top: rowMiddle.bottom
        width: 640
        height: 7

        Rectangle{
            width: 7
            height: 7
            color: "red"
        }
        Rectangle{
            width: parent.width - 14
            height: 7
            color: "red"
        }
        Rectangle{
            width: 7
            height: 7
            color: "red"
        }
    }

}
