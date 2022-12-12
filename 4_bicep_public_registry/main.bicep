targetScope = 'subscription'

// geo location
param location string= 'westeurope'
// wait seconds
param waitSeconds int = 20

// local variables
var lesson = 4

resource rg 'Microsoft.Resources/resourceGroups@2020-10-01' = {
  name: 'bicep-rg-${lesson}'
  location: location
}

// https://github.com/Azure/bicep-registry-modules/blob/main/modules/samples/array-loop/main.bicep
module arrayLoop 'br/public:samples/array-loop:1.0.1' = {
  scope: rg
  name: 'arrayLoop'
}

// https://github.com/Azure/bicep-registry-modules/blob/main/modules/deployment-scripts/wait/main.bicep
module delayDeployment 'br/public:deployment-scripts/wait:1.0.1' = {
  scope: rg
  name: 'delayDeployment'
  params: {
    waitSeconds: waitSeconds
    location: location
  }
}
