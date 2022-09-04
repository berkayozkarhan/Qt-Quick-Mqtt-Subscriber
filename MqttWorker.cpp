#include "MqttWorker.h"

MqttWorker::MqttWorker(QObject *parent)
    : QObject{parent}
{
    m_client = new QMqttClient(this);
    m_client->setHostname("127.0.0.1");
    m_client->setPort(qint16(1883));

    connect(m_client, &QMqttClient::stateChanged, this, &MqttWorker::updateLogStateChange);
    connect(m_client, &QMqttClient::disconnected, this, &MqttWorker::brokerDisconnected);
    connect(m_client, &QMqttClient::messageReceived, this, &MqttWorker::messageReceived);
    connect(m_client, &QMqttClient::pingResponseReceived, this, &MqttWorker::pingResponseReceived);
    connect(m_client, &QMqttClient::connected, this, &MqttWorker::mqttClient_connected);

    updateLogStateChange();

}

bool MqttWorker::start()
{
    if(m_client->state() == QMqttClient::Connected)
        m_client->disconnectFromHost();

    m_client->connectToHost();
    return true;
}

bool MqttWorker::stop()
{
    m_client->disconnectFromHost();
    return true;
}

void MqttWorker::updateLogStateChange()
{
    emit client_state_changed(m_client->state());
}

void MqttWorker::brokerDisconnected()
{
    emit client_disconnected();
}

void MqttWorker::messageReceived(const QByteArray &message, const QMqttTopicName &topic)
{
    QStringList strList = topic.name().split('/');
    QString chg = strList[strList.length() - 1]; // last index.
    emit client_message_received(message, chg);
}

void MqttWorker::pingResponseReceived()
{
    const QString content = QDateTime::currentDateTime().toString()
            + QLatin1String(" Ping Response")
            + QLatin1Char('\n');
    qDebug("%s", qUtf8Printable(content));
}

void MqttWorker::mqttClient_connected()
{
    emit client_connected();

    QString qos = "0";
    QMqttTopicFilter filter = QMqttTopicFilter(QLatin1String("app/test/#"));
    auto subscription = m_client->subscribe(filter, qos.toUInt());
    if(!subscription){
        qDebug("Error : Could not subscribe. Is there a valid connection?");
        return;
    }

    emit client_subscribed("app/test/#");

}
