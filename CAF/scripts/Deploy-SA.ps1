#variable used within the script
$location = "westeurope"
$resourcegroupname = "rg-tfbackend-dev"
$storageAccountName = "satfbackendkimmymoredev"

#Check if resourcegroup exists
$exists = Get-AzStorageAccount -ResourceGroupName $resourcegroupname -Name $storageAccountName
If ($exists -eq $True) {
    Write-Host "Storage Account already exists"
}
Else {
    
    #create new resourcegroup
    New-AzResourceGroup `
        -Location $location `
        -ResourceGroupName $resourcegroupname

    #create storage account for TF backend
    $SA = New-AzStorageAccount `
        -Name $storageAccountName `
        -Location $location `
        -ResourceGroupName $resourcegroupname `
        -SkuName "Standard_GRS"


    #get keys for stoage account context
    $sakey = Get-AzStorageAccountKey -AccountName $sa.StorageAccountName -ResourceGroupName $resourcegroupname

    #set storage account blob context
    $context = New-AzStorageContext -StorageAccountName $sa.StorageAccountName -StorageAccountKey $sakey.Value[0]

    #Create container in blob on storage account
    New-AzStorageContainer -Name "tf-state" -Context $context
}