Feature: Crypto Ticker Mode Toggling
  In order to show latest crypto currency information
  As a user
  I want to enable and disable crypto-ticker-mode

  Scenario: Enable crypto-ticker-mode
    When I turn on crypto-ticker-mode
    Then the mode line should contain "---"
