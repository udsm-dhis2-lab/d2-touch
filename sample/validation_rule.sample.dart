final Map<String, dynamic> sampleValidationRule = {
  "pager": {"page": 1, "pageCount": 1, "total": 37, "pageSize": 50},
  "validationRules": [
    {
      "created": "2011-12-24T12:24:22.817",
      "lastUpdated": "2014-03-04T01:43:47.165",
      "name": "Measles, Slept under LLITN last night, <1 year Fixed",
      "id": "sxamEpoUXb5",
      "displayName": "Measles, Slept under LLITN last night, <1 year Fixed",
      "description": "Question asked at Measles",
      "displayFormName": "Measles, Slept under LLITN last night, <1 year Fixed",
      "operator": "less_than_or_equal_to",
      "displayInstruction":
          "Slept under LLIN at measles (fixed < 1y) cannot be higher than measles doses given (fixed < 1y)",
      "periodOffset": 0,
      "periodType": "Monthly",
      "instruction":
          "Slept under LLIN at measles (fixed < 1y) cannot be higher than measles doses given (fixed < 1y)",
      "rightSide": {
        "expression": "#{YtbsuPPo010.Prlt0C1RF0s}",
        "description": "Measles, <1 year Fixed[34.292]",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      },
      "leftSide": {
        "expression": "#{GCGfEY82Wz6.Prlt0C1RF0s}",
        "description":
            "At Measles, slept under LLITN last night, <1 year Fixed",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      }
    },
    {
      "created": "2014-07-16T12:56:42.441",
      "lastUpdated": "2014-07-16T17:23:51.253",
      "name": "PCV 2 <= PCV 1",
      "id": "P2igXCbites",
      "displayName": "PCV 2 <= PCV 1",
      "description": "PCV 2 must be equal or lower than PCV 1 doses given",
      "displayFormName": "PCV 2 <= PCV 1",
      "operator": "less_than_or_equal_to",
      "displayInstruction": "PCV 2 cannot be higher than PCV 1 doses given",
      "periodOffset": 0,
      "periodType": "Monthly",
      "instruction": "PCV 2 cannot be higher than PCV 1 doses given",
      "rightSide": {
        "expression": "#{xc8gmAKfO95}",
        "description": "PCV 1",
        "missingValueStrategy": "NEVER_SKIP",
        "slidingWindow": false
      },
      "leftSide": {
        "expression": "#{mGN1az8Xub6}",
        "description": "PCV 2",
        "missingValueStrategy": "NEVER_SKIP",
        "slidingWindow": false
      }
    },
    {
      "created": "2014-07-16T12:57:40.854",
      "lastUpdated": "2014-07-16T17:24:00.040",
      "name": "PCV 3 <= PCV 2",
      "id": "aSo0d3XGZgY",
      "displayName": "PCV 3 <= PCV 2",
      "description": "PCV 3 must be equal or lower than PCV 2 doses given",
      "displayFormName": "PCV 3 <= PCV 2",
      "operator": "less_than_or_equal_to",
      "displayInstruction": "PCV 3 cannot be higher than PCV 2 doses given",
      "periodOffset": 0,
      "periodType": "Monthly",
      "instruction": "PCV 3 cannot be higher than PCV 2 doses given",
      "rightSide": {
        "expression": "#{mGN1az8Xub6}",
        "description": "PCV 2",
        "missingValueStrategy": "NEVER_SKIP",
        "slidingWindow": false
      },
      "leftSide": {
        "expression": "#{L2kxa2IA2cs}",
        "description": "PCV 3",
        "missingValueStrategy": "NEVER_SKIP",
        "slidingWindow": false
      }
    },
    {
      "created": "2011-12-24T12:24:22.817",
      "lastUpdated": "2014-03-04T01:44:58.329",
      "name": "Penta3, Exclusive breastfeeding, <1 year Fixed",
      "id": "B3cosSOA63b",
      "displayName": "Penta3, Exclusive breastfeeding, <1 year Fixed",
      "description": "Question asked at Penta3 vs number of Penta3",
      "displayFormName": "Penta3, Exclusive breastfeeding, <1 year Fixed",
      "operator": "less_than_or_equal_to",
      "displayInstruction":
          "Exclusive breastfeeding at time of penta 3 (fixed < 1y) cannot be higher than penta 3 doses given (fixed < 1y)",
      "periodOffset": 0,
      "periodType": "Monthly",
      "instruction":
          "Exclusive breastfeeding at time of penta 3 (fixed < 1y) cannot be higher than penta 3 doses given (fixed < 1y)",
      "rightSide": {
        "expression": "#{n6aMJNLdvep.Prlt0C1RF0s}",
        "description": "Penta3, <1 year Fixed[25.292]",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      },
      "leftSide": {
        "expression": "#{pEOVd4Z3TAS.Prlt0C1RF0s}",
        "description":
            "People asked at Penta3 if Exclusive breastfeeding, <1 year Fixed",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      }
    },
    {
      "created": "2011-12-24T12:24:22.817",
      "lastUpdated": "2014-03-04T01:45:07.235",
      "name": "Penta3, Exclusive breastfeeding, <1 year Outreach",
      "id": "O7I6pSSF79K",
      "displayName": "Penta3, Exclusive breastfeeding, <1 year Outreach",
      "description": "Question asked at Penta3 vs number of Penta3",
      "displayFormName": "Penta3, Exclusive breastfeeding, <1 year Outreach",
      "operator": "less_than_or_equal_to",
      "displayInstruction":
          "Exclusive breastfeeding at time of penta 3 (outreach < 1y) cannot be higher than penta 3 doses given (outreach < 1y)",
      "periodOffset": 0,
      "periodType": "Monthly",
      "instruction":
          "Exclusive breastfeeding at time of penta 3 (outreach < 1y) cannot be higher than penta 3 doses given (outreach < 1y)",
      "rightSide": {
        "expression": "#{n6aMJNLdvep.V6L425pT3A0}",
        "description": "Penta3, <1 year Outreach[25.290]",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      },
      "leftSide": {
        "expression": "#{pEOVd4Z3TAS.V6L425pT3A0}",
        "description":
            "People asked at Penta3 if Exclusive breastfeeding, <1 year Outreach",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      }
    },
    {
      "created": "2011-12-24T12:24:22.817",
      "lastUpdated": "2014-03-04T01:36:56.171",
      "name": "BCG, Early breastfeeding, <1 year Fixed",
      "id": "wVUSW5c5Pkp",
      "displayName": "BCG, Early breastfeeding, <1 year Fixed",
      "description":
          "Early breastfeeding at BCG (fixed) cannot be higher than BCG doses given (fixed)",
      "displayFormName": "BCG, Early breastfeeding, <1 year Fixed",
      "operator": "less_than_or_equal_to",
      "displayInstruction":
          "Early breastfeeding at BCG (fixed) cannot be higher than BCG doses given (fixed)",
      "periodOffset": 0,
      "periodType": "Monthly",
      "instruction":
          "Early breastfeeding at BCG (fixed) cannot be higher than BCG doses given (fixed)",
      "rightSide": {
        "expression": "#{s46m5MS0hxu.Prlt0C1RF0s}",
        "description": "BCG doses given < 12 m Fixed",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      },
      "leftSide": {
        "expression": "#{dU0GquGkGQr.Prlt0C1RF0s}",
        "description": "Question asked at BCG, < 12 m Fixed",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      }
    },
    {
      "created": "2011-12-24T12:24:22.817",
      "lastUpdated": "2014-03-04T01:43:59.258",
      "name": "Measles, Slept under LLITN last night, >=1 year Fixed",
      "id": "sWlF63K4G6c",
      "displayName": "Measles, Slept under LLITN last night, >=1 year Fixed",
      "description": "Question asked at Measles",
      "displayFormName":
          "Measles, Slept under LLITN last night, >=1 year Fixed",
      "operator": "less_than_or_equal_to",
      "displayInstruction":
          "Slept under LLIN at measles (fixed > 1y) cannot be higher than measles doses given (fixed > 1y)",
      "periodOffset": 0,
      "periodType": "Monthly",
      "instruction":
          "Slept under LLIN at measles (fixed > 1y) cannot be higher than measles doses given (fixed > 1y)",
      "rightSide": {
        "expression": "#{YtbsuPPo010.psbwp3CQEhs}",
        "description": "Measles, >=1 year Fixed[34.291]",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      },
      "leftSide": {
        "expression": "#{GCGfEY82Wz6.psbwp3CQEhs}",
        "description":
            "At Measles, Slept under LLITN last night, >=1 year Fixed",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      }
    },
    {
      "created": "2011-12-24T12:24:22.817",
      "lastUpdated": "2014-03-04T01:45:42.532",
      "name": "Penta3, Exclusive breastfeeding, >=1 year Outreach",
      "id": "rdZFSe8Ay0r",
      "displayName": "Penta3, Exclusive breastfeeding, >=1 year Outreach",
      "description": "Question asked at Penta3 vs number of Penta3",
      "displayFormName": "Penta3, Exclusive breastfeeding, >=1 year Outreach",
      "operator": "less_than_or_equal_to",
      "displayInstruction":
          "Exclusive breastfeeding at time of penta 3 (outreach > 1y) cannot be higher than penta 3 doses given (outreach > 1y)",
      "periodOffset": 0,
      "periodType": "Monthly",
      "instruction":
          "Exclusive breastfeeding at time of penta 3 (outreach > 1y) cannot be higher than penta 3 doses given (outreach > 1y)",
      "rightSide": {
        "expression": "#{n6aMJNLdvep.hEFKSsPV5et}",
        "description": "Penta3, >=1 year Outreach[25.289]",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      },
      "leftSide": {
        "expression": "#{pEOVd4Z3TAS.hEFKSsPV5et}",
        "description":
            "People asked at Penta3 if Exclusive breastfeeding, >=1 year Outreach",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      }
    },
    {
      "created": "2011-12-24T12:24:22.817",
      "lastUpdated": "2014-03-04T01:44:07.678",
      "name": "Measles, Slept under LLITN last night, >=1 year Outreach",
      "id": "ZRLOcDaREUF",
      "displayName": "Measles, Slept under LLITN last night, >=1 year Outreach",
      "description": "Question asked at Measles",
      "displayFormName":
          "Measles, Slept under LLITN last night, >=1 year Outreach",
      "operator": "less_than_or_equal_to",
      "displayInstruction":
          "Slept under LLIN at measles (outreach > 1y) cannot be higher than measles doses given (outreach > 1y)",
      "periodOffset": 0,
      "periodType": "Monthly",
      "instruction":
          "Slept under LLIN at measles (outreach > 1y) cannot be higher than measles doses given (outreach > 1y)",
      "rightSide": {
        "expression": "#{YtbsuPPo010.hEFKSsPV5et}",
        "description": "Measles, >=1 year Outreach[34.289]",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      },
      "leftSide": {
        "expression": "#{GCGfEY82Wz6.hEFKSsPV5et}",
        "description":
            "At Measles, Slept under LLITN last night, >=1 year Outreach",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      }
    },
    {
      "created": "2011-12-24T12:24:22.817",
      "lastUpdated": "2014-03-04T01:45:20.300",
      "name": "Penta3, Exclusive breastfeeding, >=1 year Fixed",
      "id": "UGR3QXRZZGL",
      "displayName": "Penta3, Exclusive breastfeeding, >=1 year Fixed",
      "description": "Question asked at Penta3 vs number of Penta3",
      "displayFormName": "Penta3, Exclusive breastfeeding, >=1 year Fixed",
      "operator": "less_than_or_equal_to",
      "displayInstruction":
          "Exclusive breastfeeding at time of penta 3 (fixed > 1y) cannot be higher than penta 3 doses given (fixed > 1y)",
      "periodOffset": 0,
      "periodType": "Monthly",
      "instruction":
          "Exclusive breastfeeding at time of penta 3 (fixed > 1y) cannot be higher than penta 3 doses given (fixed > 1y)",
      "rightSide": {
        "expression": "#{n6aMJNLdvep.psbwp3CQEhs}",
        "description": "Penta3, >=1 year Fixed[25.291]",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      },
      "leftSide": {
        "expression": "#{pEOVd4Z3TAS.psbwp3CQEhs}",
        "description":
            "People asked at Penta3 if Exclusive breastfeeding, >=1 year Fixed",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      }
    },
    {
      "created": "2011-12-24T12:24:22.817",
      "lastUpdated": "2014-03-04T01:37:06.545",
      "name": "BCG, Early breastfeeding, <1 year Outreach",
      "id": "Xk6lYPtiA1e",
      "displayName": "BCG, Early breastfeeding, <1 year Outreach",
      "description":
          "Early breastfeeding at BCG (outreach) cannot be higher than BCG doses given (outreach)",
      "displayFormName": "BCG, Early breastfeeding, <1 year Outreach",
      "operator": "less_than_or_equal_to",
      "displayInstruction":
          "Early breastfeeding at BCG (outreach) cannot be higher than BCG doses given (outreach)",
      "periodOffset": 0,
      "periodType": "Monthly",
      "instruction":
          "Early breastfeeding at BCG (outreach) cannot be higher than BCG doses given (outreach)",
      "rightSide": {
        "expression": "#{s46m5MS0hxu.V6L425pT3A0}",
        "description": "BCG doses given < 12 Outreach",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      },
      "leftSide": {
        "expression": "#{dU0GquGkGQr.V6L425pT3A0}",
        "description": "Asked at BCG if early breastfeeding, < 12 m Outreach",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      }
    },
    {
      "created": "2011-12-24T12:24:22.817",
      "lastUpdated": "2014-03-04T01:43:37.528",
      "name": "Measles, Slept under LLITN last night, <1 year Outreach",
      "id": "AtsPA2YokRq",
      "displayName": "Measles, Slept under LLITN last night, <1 year Outreach",
      "description": "Question asked at Measles",
      "displayFormName":
          "Measles, Slept under LLITN last night, <1 year Outreach",
      "operator": "less_than_or_equal_to",
      "displayInstruction":
          "Slept under LLIN at measles (outreach <1y) cannot be higher than measles doses given (outreach <1y)",
      "periodOffset": 0,
      "periodType": "Monthly",
      "instruction":
          "Slept under LLIN at measles (outreach <1y) cannot be higher than measles doses given (outreach <1y)",
      "rightSide": {
        "expression": "#{YtbsuPPo010.V6L425pT3A0}",
        "description": "Measles, <1 year Outreach[34.290]",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      },
      "leftSide": {
        "expression": "#{GCGfEY82Wz6.V6L425pT3A0}",
        "description":
            "At Measles, Slept under LLITN last night, <1 year Outreach",
        "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING",
        "slidingWindow": false
      }
    }
  ]
};
