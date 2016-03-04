require 'rails_helper'

RSpec.feature "Cancel Registration", type: :feature do
  let!(:user) { User.create(email: email, password: password, password_confirmation: password) }
  let(:email) { 'jill@example.com' }
  let(:password) { 'password' }

  before do
    visit('/users/sign_in')
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    click_button("Sign in")
    # Sign in
    visit('/users/edit')
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    click_link('Cancel my account')
    # Cancel registration
    # NOTE: Poltergeist ignore js alert/confirm dialogs
  end

  it "displays a goodbye message" do
  expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
  end

  # Try to sign in again
  it "does not allow the user to sign in again" do
    visit('/users/sign_in')
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    click_button("Sign in")
    expect(page).to have_content('Invalid email or password.')
  end

end
