Given(/^an envelope with a document constucted in ruby$/) do
  @envelope = Philographer::Envelope.new({
    emailBlurb: 'Test email is testing',
    emailSubject: 'Test email',
  })
  path = File.expand_path('../../../spec/test_files/basic.pdf', __FILE__)
  @envelope.documents << Philographer::Document.new({
    path: path.to_s,
    id: 1
  })

  recipient = Philographer::Recipient.new({
    type: 'signer',
    email: 'test@test.com',
    name: 'Jon Doe'
  })
  recipient.tabs << Philographer::Tab.new({
    type: 'signHere',
    x_position: 100,
    y_position: 100,
    document_id: 1,
    page_number: 1
  })
  @envelope.recipients << recipient
end

When(/^the constucted envelope has been submitted to DocuSign$/) do
  load_credentials(true)
  @envelope.save
end

Then(/^the envelope should have the DocuSign ID available$/) do
  @envelope.id.wont_be_nil
end

Given(/^an envelope with a template constructed in ruby$/) do
  @envelope = Philographer::Envelope.new({
    status: 'sent',
    template_id: "2912c004-7aea-4305-8ec7-3e58ac444b30"
  })

  recipient = Philographer::TemplateRole.new({
    role_name: 'mySigner',
    email: 'test@test.com',
    name: 'Jon Doe'
  })

  @envelope.template_roles << recipient
end

When(/^a philographer user has requested data on envelopes$/) do
  load_credentials(true)
  @envelopes = Philographer::Envelope.fetch(from_date: Date.civil(2013), status: 'Completed')
end

Then(/^an array of relevant envelope objects should be retrieved$/) do
  assert @envelopes.all?{|e| e.is_a?(Philographer::Envelope)}, "Expected all returned objects to be of type Philographer::Envelope, instead found: #{@envelopes.map{|e| e.class}.inspect}"
end
