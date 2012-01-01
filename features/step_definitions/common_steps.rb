Then /^I should see "([^"]*)" as the winner$/ do |option|
  find("#winner").text.should == option
end
