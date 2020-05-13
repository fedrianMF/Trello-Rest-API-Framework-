@crud_lists
Feature: C-R-U-D Lists
    @get
    Scenario Outline: get list
        Given DefinesList "GET" request to "/lists/<id>"
        Examples:
        | id |
        | 5eb9ba14074fa644a2dac991  |
        | 5eb9ba14074fa644a2dac992  |
        | 5ebac19b1e040e525d9851c2  |
        When The requestList is sent
        #And The schema is validated with "schema.json"
        Then The statusList code should be 200
