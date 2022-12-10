param vnetObj object = {
  name: 'vnet'
  location: resourceGroup().location
  addressSpace: '10.1.0.0/23'
}

param subnetsObj object = {
  subnet1: {
    name: 'resources'
    addressPrefix: '10.1.0.0/24'
  }
  subnet2: {
    name: 'gateway'
    addressPrefix: '10.1.1.0/24'
  }
}

// loop trough a dictionary
resource vnet 'Microsoft.Network/virtualNetworks@2022-05-01' =  {
  name: vnetObj.name
  location: vnetObj.location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetObj.addressSpace
      ]
    }
    subnets:  [for subnet in items(subnetsObj): {
      name: subnet.value.name
      properties: {
        addressPrefix: subnet.value.addressPrefix
      }
    }]
  }

}

