Feature: Entrepreneur gets Business Plan evaluated
  In order to have a Business Plan in the best possible shape
  An entrepreneur
  Wants to get the plan evaluated by MadLab.
  
  Background:
    Given users:
    | Role         | Username | First name | Last name | Email             | Address 1     | Address 2 | City | Zip    | Country | State    | Phone        | About                |
    | entrepreneur | asmith   | Adam       | Smith     | asmith@yahoo.com  | 1 Way Str.    |           | Oslo | 332244 | Norway  | Akershus | 298-044-1212 | Skilled entrepreneur |
    | advisor      | fdiller  | Frank      | Diller    | fdiller@yahoo.com | High Way Str. |           | Oslo | 332244 | Norway  | Akershus | 111-023-1111 | Skilled advisor      |
    And a business plan that contains @title section: "Hooking tool for farm"
    And contains "General" complex section:
    | Name       | Email             | Address 1     | Address 2 | City | Zip    | Country | State    | Phone        | About                |
    | Adam Smith | asmith@yahoo.com  | 1 Way Str.    |           | Oslo | 332244 | Norway  | Akershus | 298-044-1212 | Skilled entrepreneur |
    And contains "About" complex section:
    | Project name | Category        | Field of usage     | Which fields does the solve | MadLab Partners you may need contact with |
    | Hook Tool    | categories.txt  | field_of_usage.txt | fields_it_solves.txt        | madlab_partners.txt                       |
    And contains descriptioin sections:
    | Section title        | Section content file    |
    | Business Idea        | business_idea.txt       |
    | Product Description  | product.txt             |
    | Market Analysis      | market_analysis.txt     |
    | Competitors Analysis | competitor_analysis.txt |
    | Strategy             | strategy.txt            |
    | Progression Plan     | progression_plan.txt    |
    | Finances             | finances.txt            |
    | Summary              | summary.txt             |
    And contains "Attachment" upload/download section
    And contains "Thoughts & wishes" complex section:
    | Market geography | Size of market        | How far is the idea developed | Possible production or industrial partners | Possible suppliers | Possible distrubitors | Idea or patternprotection needed | Possible competitors developing similar technology | 
    | geo_market.txt   | The world via deLaval | Idea is technically tested    | partners.txt                               | suppliers.txt      | distributors.txt      | No                               | competitors.txt                                    |
#    | Market geography | Size of market        | How far is the idea developed | Commercialization | Possible production or industrial partners | Possible suppliers | Possible distrubitors | Idea or patternprotection needed | Possible competitors developing similar technology | How did the idea appear and who do you think has the wonership and the right for commercalization |
#    | geo_market.txt   | The world via deLaval | Idea is technically tested    | commerce.txt      | partners.txt                               | suppliers.txt      | distributors.txt      | No                               | competitors.txt                                    | Project owner                                                                                     |
    
  @javascript
  Scenario: Entrepreneur submitted Business Plan for evaluation
    When the entrepreneur submitted a @business_plan for evaluation
    Then he can browse the @business_plan
    
  @javascript
  Scenario: Admin assigned advisors to Business Plan
    Given the entrepreneur submitted a @business_plan for evaluation
    When the admin assigned the @advisor to the @business_plan
    Then the @advisor can see the @business_plan in his list
    And he can browse the @business_plan
