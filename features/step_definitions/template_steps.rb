Given(/^a template constructed in ruby$/) do
  @template = Philographer::Template.new({})
  path = File.expand_path('../../../spec/test_files/basic.pdf', __FILE__)
  @template.documents << Philographer::Document.new({
    path: path.to_s,
    id: 1
  })

  recipient = Philographer::Recipient.new({
    type: 'signer',
    role_name: 'mySigner'
  })
  recipient.tabs << Philographer::Tab.new({
    type: 'signHere',
    x_position: 100,
    y_position: 100,
    document_id: 1,
    page_number: 1
  })
  @template.recipients << recipient
end

When(/^the constructed template has been submitted to DocuSign$/) do
  load_credentials(true)
  @template.save
end

Then(/^the template should have the DocuSign ID available$/) do
  pending # express the regexp above with the code you wish you had
end
