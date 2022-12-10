targetScope = 'subscription'

param location string= 'westeurope'

var lesson = 0

resource rg 'Microsoft.Resources/resourceGroups@2020-10-01' = {
  name: 'bicep-rg-${lesson}'
  location: location
}

module storageModule 'storage.bicep' = {
  name: 'storage'
  scope: resourceGroup(rg.name)
}
