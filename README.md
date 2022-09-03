


Qt Quick Mqtt Subscriber.

Official mqtt lib : https://code.qt.io/cgit/qt/qtmqtt.git/tree/?h=6.1.3


Install Qt Mqtt Library:

>git clone git://code.qt.io/qt/qtmqtt.git --branch=6.1.3
>cd qtmqtt
>mkdir build && cd build
>export $QMAKE_PATH="YOUR_QMAKE_PATH, usually in Qt/x.x.x/gcc_64/bin/qmake"
>$QMAKE_PATH/qmake -r ..
>make
>sudo make install


update .pro file :


 QT += mqtt

You are read to go.

Run :
    > cd scripts
    > sh install.sh
    >python3 __main__.py


Build :
First, export your qmake path to env. usually in Qt/x.x.x/gcc_64/bin directory, Qt is the directory that you installed your Qt.
> export QT_QMAKE_PATH="your/qmake/path"
> qmake -r .
> make -j16
> ./MqttTry_Quick
