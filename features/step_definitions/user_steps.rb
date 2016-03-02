Given /^I am at the home page$/ do
  visit "/"
end

Then /^I should see "([^\"]*)"$/ do |text|
  expect(page).to have_content text
end