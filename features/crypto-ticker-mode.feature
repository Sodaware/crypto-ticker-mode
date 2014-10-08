Feature: Crypto Ticker Mode Toggling
  In order to show latest crypto currency information
  As a user
  I want to enable and disable crypto-ticker-mode

  Scenario: Enable crypto-ticker-mode
    When I turn on crypto-ticker-mode
    Then the mode line should contain "crypto-ticker-mode-modeline-text"
  
  Scenario: Disable crypto-ticker-mode
    When I turn off crypto-ticker-mode
    Then the mode line should not contain "crypto-ticker-mode-modeline-text"
