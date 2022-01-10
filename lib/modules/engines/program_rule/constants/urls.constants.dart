final PROGRAM_RULE_VARIABLE_URL =
    'programRuleVariables.json?fields=id,displayName,programRuleVariableSourceType,program[id],programStage[id],dataElement[id],trackedEntityAttribute[id],useCodeForOptionSet&paging=false&filter=program.id:eq:Y7Ah3ALVDoW';
final PROGRAM_RULE_URL =
    'programRules.json?fields=id,displayName,condition,description,program[id],programStage[id],priority,programRuleActions[id,content,location,data,programRuleActionType,programStageSection[id],dataElement[id],trackedEntityAttribute[id],programIndicator[id],programStage[id]]&paging=false&filter=program.id:eq:Y7Ah3ALVDoW';
final PROGRAM_STAGE_DATAELEMENTS =
    'programs/Y7Ah3ALVDoW.json?fields=id,programRuleVariables[programRuleVariables.json?fields=id,displayName,programRuleVariableSourceType,program[id],programStage[id],dataElement[id],trackedEntityAttribute[id],useCodeForOptionSet],programStages[programStageDataElements[dataElement[id,valueType,optionSetValue,optionSet]]]';
final OPTION_SETS_URL =
    'optionSets.json?fields=id,options[id,name,code]&paging=false';
final EVENT_URL = 'events';
