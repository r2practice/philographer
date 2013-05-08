Feature: Managing Signature Request Envelopes

  This is the core object for a DocuSign integration it represents a single
  request for signature(s) on a document.

  @envelopes
  Scenario: Creating a new envelope
    Given an envelope with a document constucted in ruby
    When the constucted envelope has been submitted to DocuSign
    Then the envelope should have the DocuSign ID available
