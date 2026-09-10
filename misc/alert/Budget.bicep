param budgetName string = 'monthly-azure-budget-${env}'
param budgetAmount int = 300

param notificationEmails array = [
  'finops@example.com'
]

resource monthlyBudget 'Microsoft.Consumption/budgets@2023-03-01' = {
  name: budgetName

  properties: {
    amount: budgetAmount
    category: 'Cost'
    timeGrain: 'Monthly'

    timePeriod: {
      startDate: '2026-10-01T00:00:00Z'
    }

    notifications: {
      Actual_80: {
        enabled: true
        operator: 'GreaterThanOrEqualTo'
        threshold: 80
        thresholdType: 'Actual'
        contactEmails: notificationEmails
        contactGroups: []
        contactRoles: []
        locale: 'en-us'
      }

      Actual_90: {
        enabled: true
        operator: 'GreaterThanOrEqualTo'
        threshold: 90
        thresholdType: 'Actual'
        contactEmails: notificationEmails
        contactGroups: []
        contactRoles: []
        locale: 'en-us'
      }

      Actual_100: {
        enabled: true
        operator: 'GreaterThanOrEqualTo'
        threshold: 100
        thresholdType: 'Actual'
        contactEmails: notificationEmails
        contactGroups: []
        contactRoles: []
        locale: 'en-us'
      }
    }
  }
}
