Feature: Decision making
  As a visitor
  I want to be helped through a decision
  So I don't screw it up

  Scenario: Success
    When I go to the homepage
    Then I should see "How can I help you?"
    When I fill in "Question" with "Which car should I buy?"
    And I press "Continue"
    Then I should see "Okay, what are your options?"
    When I fill in the following:
      | Option #1 | 2008 Ford Focus   |
      | Option #2 | 2007 Toyota Camry |
    And I press "Continue"
    Then I should see "Now, what factors affect your decision?"
    When I fill in the following:
      | Factor #1 | Price       |
      | Factor #2 | Safety      |
      | Factor #3 | Reliability |
    And I fill in the following:
      | Weight #1 | 9 |
      | Weight #2 | 8 |
      | Weight #3 | 7 |
    And I press "Continue"
    Then I should see "Great! Let’s start scoring your options."
    When I fill in the following within the "2008 Ford Focus" column:
      | Price       | 8 |
      | Safety      | 6 |
      | Reliability | 7 |
    And I fill in the following within the "2007 Toyota Camry" column:
      | Price       | 6 |
      | Safety      | 8 |
      | Reliability | 7 |
    And I press "Continue"
    Then I should see "2008 Ford Focus" as the winner
    And I should see "50.3%" confidence
    And I should see "70.4%" within the "2008 Ford Focus" section
    And I should see "69.6%" within the "2007 Toyota Camry" section
