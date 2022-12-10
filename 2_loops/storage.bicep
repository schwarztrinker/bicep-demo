targetScope = 'resourceGroup'

// ! Bicep Template Parameters are a way to specify input values for a Bicep template. They allow you to customize the behavior of your template by providing values for certain properties or settings at deployment time. 
//Parameters are defined using the param keyword, and can be used in expressions and assignments within your template. For example, you could define a parameter for the location of an Azure resource, and then use that parameter in the location property of the resource. 
//This way, you can deploy the same template in different locations by providing a different value for the location parameter.
param storageName string = 'maddinsst'
param location string = resourceGroup().location

// ! Bicep Template Variables are a way to store and use values within a Bicep template. They allow you to define values that can be used throughout your template, making it easier to manage and update your Azure resources. 
// Variables are defined using the var keyword, and can be used in expressions and assignments within your template. For example, you could define a variable for the name of an Azure resource, and then use that variable in the name property of the resource. 
// This way, you only need to update the variable definition if you want to change the name of the resource, rather than having to update it in multiple places in your template.

var skuName = 'Standard_ZRS'
var containerNames = ['active','archive','important']


resource storage 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name : storageName
  location: location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
}
resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2022-05-01' = {
  name: 'default'
  parent: storage
  properties: {
    containerDeleteRetentionPolicy: {
      allowPermanentDelete: false
      days: 7
      enabled: true
    }
  }

}

// loop through array
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = [for containerName in containerNames: {  
    name: containerName
    parent: blobServices
    properties: {
      publicAccess: 'Container'
    }
}]

// loop for specific count
resource containerCount 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = [for idx in range(1, 5): {  
  name: 'container${idx}'
  parent: blobServices
  properties: {
    publicAccess: 'Container'
  }
}]

