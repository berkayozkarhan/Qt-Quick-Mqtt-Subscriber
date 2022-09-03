#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "MqttWorker.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    MqttWorker worker;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("MqttWorker", &worker);

    const QUrl url(u"qrc:/MqttTry_Quick/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
