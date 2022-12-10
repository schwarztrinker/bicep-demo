targetScope = 'subscription'

// geo location
param location string= 'westeurope'

// local variables
var lesson = 2

resource rg 'Microsoft.Resources/resourceGroups@2020-10-01' = {
  name: 'bicep-rg-${lesson}'
  location: location
}

module storageModule 'storage.bicep' = {
  name: 'storage'
  scope: resourceGroup(rg.name)
  // modules parametes
  params: {
    storageName: 'pexonsst${lesson}'
    location: location
  }
}

module networkModule 'network.bicep' = {
  name: 'network'
  scope: resourceGroup(rg.name)
  // modules parametes
}
