global with sharing class CreateCaseAction implements copadoAiHelper.Action.Actionable {
        global String[] appliesTo() {
            System.debug('appliesTo');
            // declare for which objects this action is relevant.
            // return an empty array if the action is relevant to any object.
            return new String[]{};
        }
        global String jsonSchema() {
            System.debug('jsonSchema');
            //Description, Subject, 
            // the name will be visible to the user, so be clear and concise
            // the description will be relevant to OpenAI ... be concise but clear so OpenAI understands it
            // do note that the "examples" list will be visible to the end user, to help it know what this Action can do
            return '{'+
            '    "name": "create_case",'+
            '    "description": "create a Case record",'+
            '    "examples": ["create a case !", "contact support"],'+
            '    "parameters": {'+
            '        "type": "object",'+
            '        "properties": {'+
            '            "description": {"type": "string", "description": "The description of the case"},'+
            '            "Priority": {"type": "string", "description": "The priority of the case"},'+
            '            "Subject": {"type": "string", "description": "The subject of the case"}'+
            '        }'+
                '}'+
			'}';
        }
        global copadoAiHelper.ActionResponse call(Id contextId, Map<String, Object> args) {

            Case caseObj = new Case(Origin = 'Web', 
                                    Deflected__c = true, 
                                    Description=(String)args.get('description') , 
                                    Subject =(String)args.get('Subject') , 
                                    Priority = (String)args.get('Priority'));

            insert caseObj;
            
            return new copadoAiHelper.ActionResponse('Success: Case created : '+ 'https://copado-2f2-dev-ed.develop.lightning.force.com/lightning/r/Case/'+caseObj.Id+'/view');
        }
    }