Feature: Managing Signature Request Envelopes

  This is the core object for a DocuSign integration it represents a single
  request for signature(s) on a document.

  @envelopes @wip
  Scenario: Creating a new envelope
    Given an envelope with a document constucted in ruby
    When the constucted envelope has been submitted to DocuSign
    Then the envelope should have the DocuSign ID available

  @envelopes
  Scenario: Creating a new envelope from a template
    Given an envelope with a template constructed in ruby
    When the constucted envelope has been submitted to DocuSign
    Then the envelope should have the DocuSign ID available

  @envelopes
  Scenario: Polling for envelope data in bulk
    When a philographer user has requested data on envelopes
    Then an array of relevant envelope objects should be retrieved
