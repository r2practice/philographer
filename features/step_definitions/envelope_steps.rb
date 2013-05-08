Given(/^an envelope with a document constucted in ruby$/) do
  @envelope = Philographer::Envelope.new({
    emailBlurb: 'Test email is testing',
    emailSubject: 'Test email',
  })
  path = File.expand_path('../../test_files/basic.pdf', __FILE__)
  @envelope.documents << Philographer::Document.new(path.to_s)

  recipient = Philographer::Recipient.new({
    type: 'signer',
    email: 'test@test.com',
    name: 'Jon Doe'
  })
  recipient.tabs << Philographer::Tab.new({
    type: 'signHere',
    x_position: 100,
    y_position: 100,
    document_id: 0,
    page_number: 1
  })
  @envelope.recipients << recipient
end

When(/^the constucted envelope has been submitted to DocuSign$/) do
  @envelope.save
end

Then(/^the envelope should have the DocuSign ID available$/) do
  @envelope.docusign_id.wont_be_nil
end
