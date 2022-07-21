## install DNS role
Install-WindowsFeature -Name "DNS" -IncludeManagementTools

#region Azure DNS Config
#############################################################################################################################
$AzureDnsForwardIPs = @('168.63.129.16')

## Generic privatelink DNS forwarders..
$AzurePrivateLinkForwardZones = @(
    'privatelink.azure-automation.net',
    'privatelink.afs.azure.net',
    'privatelink.agentsvc.azure-automation.net',
    'privatelink.api.azureml.ms',
    'privatelink.azconfig.io',
    'privatelink.azure.com',
    'privatelink.azurecr.io',
    'privatelink.azure-devices.net',
    'privatelink.azurewebsites.net',
    'privatelink.blob.core.windows.net',
    'privatelink.cassandra.cosmos.azure.com',
    'privatelink.cognitiveservices.azure.com',
    'privatelink.database.windows.net',
    'privatelink.datafactory.azure.net',
    'privatelink.dfs.core.windows.net',
    'privatelink.documents.azure.com',
    'privatelink.eventgrid.azure.net',
    'privatelink.file.core.windows.net',
    'privatelink.gremlin.cosmos.azure.com',
    'privatelink.mariadb.database.azure.com',
    'privatelink.mongo.cosmos.azure.com',
    'privatelink.monitor.azure.com',
    'privatelink.mysql.database.azure.com',
    'privatelink.northeurope.azmk8s.io',
    'privatelink.northeurope.backup.windowsazure.com',
    'privatelink.ods.opinsights.azure.com',
    'privatelink.oms.opinsights.azure.com',
    'privatelink.postgres.database.azure.com',
    'flexserver.weeu.postgres.database.azure.com',
    'privatelink.queue.core.windows.net',
    'privatelink.redis.cache.windows.net',
    'privatelink.search.windows.net',
    'privatelink.service.signalr.net',
    'privatelink.servicebus.windows.net',
    'privatelink.table.core.windows.net',
    'privatelink.table.cosmos.azure.com',
    'privatelink.vaultcore.azure.net',
    'privatelink.web.core.windows.net',
    'privatelink.westeurope.azmk8s.io',
    'privatelink.westeurope.backup.windowsazure.com'
)

# $InternalDomainDNSIPs = @('10.236.1.4', '10.236.1.5') # Should be Domain controller on-prem

# # # Set the Azure Private DNS Zones as DNS Server Forward Zones
# # foreach ($item in $AzurePrivateDnsFowardZones) {
# #     Add-DnsServerConditionalForwarderZone -Name $item -MasterServers $AzureDnsForwardIPs -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
# # }

# Set the Azure Private Link DNS Zones as DNS Server Forward Zones
foreach ($item in $AzurePrivateLinkForwardZones) {
    Add-DnsServerConditionalForwarderZone -Name $item -MasterServers $AzureDnsForwardIPs -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
}

# Set the Internal Domain DNS Zones as DNS Server Forward Zones
# foreach ($item in $InternalDomainDNSForwardZones) {
#     Add-DnsServerConditionalForwarderZone -Name $item -MasterServers $InternalDomainDNSIPs -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
# }

# Set the DNS Server forward IP Addresses
Set-DnsServerForwarder -IPAddress $AzureDnsForwardIPs

# Set only the ipv4 internal IP address as DNS Server Interface
$IPAddress = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' -and $_.IPAddress -ne '127.0.0.1' }).IPAddress
$a = Get-WmiObject -namespace root\MicrosoftDNS -Class MicrosoftDNS_Server
$a.ServerAddresses.Clear()
$a.ListenAddresses = @($IPAddress)
$a.Put()
#endregion DNS Server Configuration
