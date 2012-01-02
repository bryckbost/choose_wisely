Then /^I should see "([^"]*)" as the winner$/ do |option|
  find("#winner").text.should == option
end

Then /^I should see "([^"]*)" confidence$/ do |percentage|
  find("#confidence").text.should == percentage
end

Then /^I should see errors$/ do
  error = first("#alert")
  error.should be_present
  error.text.should be_present
end
