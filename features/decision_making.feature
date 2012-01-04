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
      | Option #1 | Focus |
      | Option #2 | Camry |
    And I press "Continue"
    Then I should see "Now, what factors affect your decision?"
    When I fill in the following:
      | Factor #1 | Price       |
      | Factor #2 | Safety      |
      | Factor #3 | Reliability |
    And I press "Continue"
    Then I should see "How important are those factors?"
    When I fill in the following:
      | Price       | 9 |
      | Safety      | 8 |
      | Reliability | 7 |
    And I press "Continue"
    Then I should see "Great! Let’s start scoring your options."
    When I fill in the following:
      | Focus Price       | 8 |
      | Focus Safety      | 6 |
      | Focus Reliability | 7 |
    And I fill in the following:
      | Camry Price       | 6 |
      | Camry Safety      | 8 |
      | Camry Reliability | 7 |
    And I press "Continue"
    Then I should see "Focus" as the winner
    And I should see "50.3%" confidence
    And I should see "70.4%" within the "Focus" section
    And I should see "69.6%" within the "Camry" section

  Scenario: Missing question
    When I go to the homepage
    And I fill in "Question" with ""
    And I press "Continue"
    Then I should see errors
