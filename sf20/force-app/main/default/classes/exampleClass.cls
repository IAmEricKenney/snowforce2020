public with sharing class exampleClass 
{
	@InvocableMethod(label='Get Policies for Contacts')
    public static policyContacts [] getPolicyMap() 
    {
		policyContacts[] pConts = new policyContacts [0];
		for (Customer_Policy__c cuspol :[SELECT Id, Contact__c, Contact__r.FirstName, 
                                         Contact__r.LastName, Policy__c FROM Customer_Policy__c]
            ) 
        {
			policyContacts pc = findPolicyContactsStatic(cuspol.Policy__c, pConts);
            if(pc == null) 
            {
				pConts.add(new policyContacts(cuspol.Policy__c, 
                           cuspol.Contact__r)
                           );
            } else 
            {
                pc.contacts.add(cuspol.Contact__r);
			}
		}
		return pConts;
	}

    static policyContacts findPolicyContactsStatic(Id policyId, policyContacts [] pConts) 
    {
        for(policyContacts pc :pConts) 
        {
            if(policyId == pc.policyId) 
            {
				return pc;
			}
		}
		return null;
	}
    public policyContacts findPolicyContacts(Id policyId, policyContacts [] pConts) 
    {
        for(policyContacts pc :pConts) 
        {
            if(policyId == pc.policyId) 
            {
				return pc;
			}
		}
		return null;
	}
	public class policyContacts {
		@InvocableVariable
		public Id policyId;
		@InvocableVariable
		public Contact [] contacts;
		public policyContacts(Id policyId, Contact cont) {
			this.policyId = policyId;
            this.contacts = new Contact [] 
            { 
                cont
            };
		}
    }
} 