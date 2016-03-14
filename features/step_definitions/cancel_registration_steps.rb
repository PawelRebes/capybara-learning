Given(/^I am signed in$/) do
  visit "/users/sign_up"
  fill_in ("user_email"), with: ("jill@example.com")
  fill_in ("user_password"), with: ("Password")
  fill_in ("user_password_confirmation"), with: ("Password")
  click_button ("Sign up")
end

Given(/^I go to user profile page$/) do
  visit "/users/edit"
end

When(/^I click "(.*?)"$/) do |arg1|
  click_on (arg1)
end

Then(/^I should see goodbye message$/) do
  expect(page).to have_content("Bye! Your account has been successfully cancelled.")
end

Then(/^I shouldn't be able to log in again$/) do
  visit "/users/sign_in"
  fill_in ("user_email"), with: ("jill@example.com")
  fill_in ("user_password"), with: ("Password")
  click_button ("Sign in")
  expect(page).to have_content("Invalid email or password.")
end
