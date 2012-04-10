Feature: Entrepreneur gets Business Plan published
  In order to get in touch with the best partners of a future venture
  An entrepreneur gets his Business Plan published on MadLab web site.
  
  Background:
    Given @entrepreneur and @advisor users
    And a @business_plan

  @javascript
  Scenario: Entrepreneur submitted Business Plan for publishing
    Given the @entrepreneur submitted the @business_plan for evaluation
    When the @entrepreneur set "To publish" status in the @business_plan
    Then the @admin can see "To publish" status of the @business_plan in his list

  @javascript
  Scenario: Admin published submitted Business Plan
    Given the @entrepreneur submitted the @business_plan for evaluation
    And the @entrepreneur set "To publish" status in the @business_plan
    When the @admin set "Published" status of the @business_plan
    Then a visitor can see the @business_plan on the home page
