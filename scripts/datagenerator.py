import time
from conf import Conf
import paho.mqtt.client as paho
import random


class DataGenerator:
    def __init__(self):
        self._connected_to_broker = False
        self._host = Conf.BROKER_HOST
        self._port = Conf.BROKER_PORT
        self._min = Conf.DATA_MIN_VALUE
        self._max = Conf.DATA_MAX_VALUE
        self._period_in_ms = Conf.PERIOD_IN_MS
        self._target_topic = Conf.TARGET_TOPIC
        self._client = paho.Client()
        self._client.on_connect = self.on_connected
        self._client.on_disconnect = self.on_disconnected
        self._client.on_publish = self.on_published
        self._last_random = 0
        self.__is_running = False

    @property
    def is_running(self):
        return self.__is_running

    def start(self):
        if self.is_running:
            print("Already running.")
            return
        self._client.connect(host=self._host, port=self._port, keepalive=6000)
        self.__is_running = True
        self.loop()

    def stop(self):
        pass

    def loop(self):
        while self.is_running:
            self._last_random = random.randint(0, 90)
            self._client.publish(topic=self._target_topic, payload=f"{self._last_random}")
            time.sleep(self._period_in_ms / 1000)

    def on_connected(self, client, userdata, flags, rc):
        print("connected with result code : ", str(rc))
        self._connected_to_broker = True

    def on_disconnected(self, client, userdata, rc):
        print("Disconnected with result code : ", str(rc))
        self._connected_to_broker = False

    def on_published(self, client, userdata, mid):
        print("Published : ", self._last_random)
