targetScope = 'subscription'

// geo location
param location string= 'westeurope'

// local variables
var lesson = 1

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
