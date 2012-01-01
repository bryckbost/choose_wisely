Then /^I should see "([^"]*)" as the winner$/ do |option|
  find("#winner").text.should == option
end

Then /^I should see "([^"]*)" confidence$/ do |percentage|
  find("#confidence").text.should == percentage
end
