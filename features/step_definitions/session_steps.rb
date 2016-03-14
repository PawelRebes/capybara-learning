Given(/^There exists following users$/) do |table|
  row = table.hashes.first
  @user = User.create(email: row["Name"], password: row["Password"], password_confirmation: row["Password"])
end

Given(/^I go to main page$/) do
  visit root_path
end

Given(/^I click in navbar "(.*?)"$/) do |arg1|
  within('.navbar') {click_link(arg1)}
end

When(/^I fill "(.*?)" field with "(.*?)"$/) do |arg1, arg2|
  fill_in (arg1), with: (arg2)
end

When(/^I click button "(.*?)"$/) do |arg1|
  click_button(arg1)
end

Then(/^I should see navigation links for guest user$/) do
  expect(page).to have_content('Home')
  #etc
end

Then(/^I should see sign in error message$/) do
  expect(page).to have_content('Invalid email or password.')
end

Then(/^I should see navigation links for signed in user$/) do
  expect(page).to have_content('Home')
  #etc
end

Then(/^I should see welcome message$/) do
  expect(page).to have_content('Welcome')
end
