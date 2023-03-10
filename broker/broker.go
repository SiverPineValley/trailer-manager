package broker

import (
	"SiverPineValley/trailer-manager/common"
	"SiverPineValley/trailer-manager/config"
	"SiverPineValley/trailer-manager/logger"
	"fmt"
	mqtt "github.com/eclipse/paho.mqtt.golang"
)

type Broker struct {
	qos     byte
	handler mqtt.MessageHandler
}

var (
	topicFuncMap = map[string]Broker{
		"gps/log": {1, GpsLogHandler},
	}
)

func initTopic(client mqtt.Client) (err error) {
	config := config.GetConfig()
	topics := config.Broker.Topics

	for _, t := range topics {
		token := client.Subscribe(t, topicFuncMap[t].qos, topicFuncMap[t].handler)
		token.Wait()
		fmt.Printf("Subscribed to topic %s", t)
	}

	return
}

func InitBroker() (err error) {
	config := config.GetConfig()

	host := config.Broker.Host
	port := config.Broker.Port
	clientId := config.Broker.ClientId
	username := config.Broker.Username
	pwd := config.Broker.Password

	if host == "" {
		host = common.HostDefault
	}

	if port <= 0 {
		port = common.PortDefault
	}

	if clientId == "" {
		return common.ConfigErr
	}

	opts := mqtt.NewClientOptions()
	opts.AddBroker(fmt.Sprintf("tcp://%s:%d", host, port))
	opts.SetClientID(clientId)
	opts.SetUsername(username)
	opts.SetPassword(pwd)
	opts.SetDefaultPublishHandler(MessagePubHandler)
	opts.OnConnect = ConnectHandler
	opts.OnConnectionLost = ConnectLostHandler
	client := mqtt.NewClient(opts)
	if token := client.Connect(); token.Wait() && token.Error() != nil {
		logger.Fatal(token.Error().Error())
	}
	initTopic(client)
	client.Disconnect(250)
	return nil
}
