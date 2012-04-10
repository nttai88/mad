Feature: Entrepreneur gets Business Plan evaluated
  In order to have a Business Plan in the best possible shape
  An entrepreneur
  Wants to get the plan evaluated by MadLab.
  
  Background:
    Given @entrepreneur and @advisor users
    And a @business_plan
    
  @javascript
  Scenario: Entrepreneur submitted Business Plan for evaluation
    When the @entrepreneur submitted the @business_plan for evaluation
    Then he can browse the @business_plan
    And can browse "General" complex section
    
  @javascript
  Scenario: Admin assigned advisors to Business Plan
    Given the @entrepreneur submitted the @business_plan for evaluation
    When the admin assigned the @advisor to the @business_plan
    Then the @advisor can see the @business_plan in his list
    And he can browse the @business_plan
