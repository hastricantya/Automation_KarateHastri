Feature: swagger api
  Background:

    * configure headers = { 'X_SESSION_TOKEN': '#(authToken)' , 'Content-Type': 'application/json', 'api_key': 'admin1234' }

  Scenario: GET api
    Given url 'https://petstore.swagger.io'
    When path '/v2/pet/240'
    And method get
    Then status 200
    And print response

  Scenario: failed GET pet byId
    Given url 'https://petstore.swagger.io'
    When path '/v2/pet/121121212'
    And method get
    Then status 404
    And print response

    Scenario: add new pet to store
      Given url 'https://petstore.swagger.io/v2/pet'
      And request { "id": 1400,"category": { "id": 24,"name": "hastri"},"name": "doggie","photoUrls": ["https://hips.hearstapps.com/hmg-prod/images/gettyimages-1667586499.jpg?crop=0.668xw:1.00xh;0.148xw,0&resize=980:*"],"tags": [{"id": 240,"name": "bulldog"}],"status": "available"}
      When method POST
      Then status 200
      And print response

  Scenario: failed add new pet to store
    Given url 'https://petstore.swagger.io/v2/pet'
    And request { "id": "sss","category": { "id": 24,"name": ""},"name": "doggie","photoUrls": ["https://hips.hearstapps.com/hmg-prod/images/gettyimages-1667586499.jpg?crop=0.668xw:1.00xh;0.148xw,0&resize=980:*"],"tags": [{"id": 240,"name": "bulldog"}],"status": "available"}
    When method POST
    Then status 500
    And print response

    Scenario: delete pet byId

      Given url 'https://petstore.swagger.io/v2/pet/1400'
      When method DELETE
      Then status 200
      And print response
