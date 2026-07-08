param prefix string
param location string

resource webPubSub 'Microsoft.SignalRService/webPubSub@2023-02-01' = {
  name: '${prefix}-wps'
  location: location
  sku: {
    name: 'Free_F1'
    tier: 'Free'
    capacity: 1
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource hub 'Microsoft.SignalRService/webPubSub/hubs@2023-02-01' = {
  parent: webPubSub
  name: 'dmpackages'
  properties: {
    anonymousConnectPolicy: 'allow'
  }
}

#disable-next-line outputs-should-not-contain-secrets
output connectionString string = webPubSub.listKeys().primaryConnectionString
