$rgName=  'bicep-rg-5'
az group create --location 'westeurope' --name $rgName

$string = -join ((97..122)| Get-Random -Count 6 | % {[char]$_})
$regName =  'bicepcr'+$string
az acr create --resource-group 'bicep-rg-5' --name $regName --sku Basic

az acr show --resource-group $rgName --name $regName --query loginServer

az bicep publish --file 0_demo.bicep --target br:$regName.azurecr.io/bicep/modules/demo:v1
