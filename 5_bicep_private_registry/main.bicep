targetScope = 'subscription'

// geo location
param location string= 'westeurope'

// local variables
var lesson = 5

resource rg 'Microsoft.Resources/resourceGroups@2020-10-01' = {
  name: 'bicep-rg-${lesson}'
  location: location
}
// CHANGE REGISTRY HERE
module storage 'br:bicepcrwhicey.azurecr.io/bicep/modules/demo:v1' = {
  name: 'storageDeploy' 
  scope: rg
  params: {
    storageName: 'mypexonstorexyz'
  }
}
