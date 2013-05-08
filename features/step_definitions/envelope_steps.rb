Given(/^an envelope with a document constucted in ruby$/) do
  @envelope = Philographer::Envelope.new
  #the rest of an envelope setup.
end

When(/^the constucted envelope has been submitted to DocuSign$/) do
  @envelope.save
end

Then(/^the envelope should have the DocuSign ID available$/) do
  @envelope.docusign_id.wont_be_nil
end
