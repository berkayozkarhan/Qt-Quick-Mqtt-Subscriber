#ifndef MQTTWORKER_H
#define MQTTWORKER_H

#include <QObject>
#include <QtMqtt/QMqttClient>
#include <QTimer>
#include <QDebug>


class MqttWorker : public QObject
{
    Q_OBJECT
public:
    explicit MqttWorker(QObject *parent = nullptr);
    Q_INVOKABLE bool start();
    Q_INVOKABLE bool stop();
    bool _is_running = false;

private:
    QMqttClient* m_client;

private slots:
    void updateLogStateChange();
    void brokerDisconnected();
    void messageReceived(const QByteArray &message, const QMqttTopicName &topic);
    void pingResponseReceived();
    void mqttClient_connected();


signals:
    void client_state_changed(int clientState);
    void client_message_received(const QByteArray &message, QString chg);
    void client_connected();
    void client_disconnected();
    void client_subscribed(QString topic);


};

#endif // MQTTWORKER_H
