Feature: Managing Signing Templates

  As a basis for a large number of identical signatures templates
  allow users of DocuSign to create signuature templates.

  @templates @wip
  Scenario: Creating a new template
    Given a template constructed in ruby
    When the constructed template has been submitted to DocuSign
    Then the template should have the DocuSign ID available
