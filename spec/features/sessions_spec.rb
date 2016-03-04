require 'rails_helper'

RSpec.feature "User Sessions", type: :feature do
  let!(:user) { User.create(email: email, password: password, password_confirmation: password) }
  let(:email) { 'jill@example.com' }
  let(:password) { 'password' }

  before do
    visit root_path
    within('.navbar') { click_link('Sign in') }
  end

  context "failure" do
    before do
      within('.navbar') { click_link('Sign in') }
      click_button('Sign in')
      # try to sign in without a password
    end

    it "displays an error message" do
      expect(page).to have_content('Invalid email or password.')
      # should still see 'Sign in' and 'Sign up'
      expect(page).not_to have_link('Profile')
      expect(page).not_to have_link('Sign out')
      # should not see 'Profile' or 'Sign out'
    end

    it "shows the correct navigation links" do
      expect(page).to have_link('Home')
      expect(page).to have_link('About')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
      expect(page).to have_link('Forgot your password?')
    end
  end

  context "success" do
    before do
      within('.navbar') { click_link('Sign up') }
      fill_in('Email', with: 'john.doe@example.com')
      fill_in('user_password', with: 'password')
      fill_in('user_password_confirmation', with: 'password')
      click_button('Sign up')
      # sign in
    end


    it "displays a welcome message" do
      expect(page).to have_content('Welcome! You have signed up successfully.')
        within('.navbar') do
          expect(page).not_to have_link('Sign in')
          expect(page).not_to have_link('Sign up')
          # should not see 'Sign in' and 'Sign up'
          expect(page).to have_link('Profile')
          expect(page).to have_link('Sign out')
          # should see 'Profile' or 'Sign out'
        end
    end

    it "shows the correct navigation links" do
      within('.navbar') do
        expect(page).to have_link('Home')
        expect(page).to have_link('About')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Sign out')
      end
    end
  end
end
