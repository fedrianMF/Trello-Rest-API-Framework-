@crud_cards
Feature: C-R-U-D Cards
    @get
    Scenario Outline: get card
        Given DefinesCard "GET" request to "/cards/<id>"
        Examples:
        | id |
        | 5ebaf4ba53b8fc57c19459ae  |
        | 5ebb5be0aeab1755c2e1f73b  |
        | 5ebb5be3d1e9825c00b9701d  |
        | 5ebb5be7b64ad58194d796f4  |
        When The requestCard is sent
        #And The schema is validated with "schema.json"
        Then The statusCard code should be 200