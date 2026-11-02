
using 'monitor-secret.bicep'

param logicAppName = 'la-entra-secret-monitor-prod'

param location = 'centralindia'

param expiryThresholdDays = 30

param senderMailbox = 'entra-monitor@contoso.com'

param alertRecipient = 'cloud-operations@contoso.com'
