require 'rails_helper'

RSpec.feature "User Registration", type: :feature do
  before do
    visit root_path
    within('.navbar') { click_link('Sign up') }
  end

  context "failure" do
    before do
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'Sign up'
    end

    it "displays an error message" do
      expect(page).to have_content("Please review the problems below")
    end

    # should still see 'Sign in' and 'Sign up'
    # should not see 'Profile' or 'Sign out'
    it "shows the correct navigation links" do
      within('.navbar') do
        expect(page).to have_link('Sign in')
        expect(page).to have_link('Sign up')
        expect(page).to_not have_link('Profile')
        expect(page).to_not have_link('Sign out')
      end
    end
  end

  context "success" do
    before do
      fill_in 'Email', with: 'jill@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'Sign up'
    end

    it "displays a welcome message" do
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end

    # should not see 'Sign in' and 'Sign up'
    # should see 'Profile' or 'Sign out'
    it "shows the correct navigation links" do
      within('.navbar') do
        expect(page).to have_link('Profile')
        expect(page).to have_link('Sign out')
        expect(page).to_not have_link('Sign in')
        expect(page).to_not have_link('Sign up')
      end
    end
  end
end
