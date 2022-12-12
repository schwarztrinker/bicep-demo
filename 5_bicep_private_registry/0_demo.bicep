targetScope = 'resourceGroup'

param storageName string = 'pexonsst'
param location string = resourceGroup().location
//var <variable-name> = <variable-value>

resource storage 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name : storageName
  location: location
  sku: {
    name: 'Standard_ZRS'
  }
  kind: 'StorageV2'
}
