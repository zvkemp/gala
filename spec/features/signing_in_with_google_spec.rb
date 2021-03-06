# frozen_string_literal: true

require 'rails_helper'

feature 'Signing in with Google' do
  before { visit root_path }

  context 'without a password' do
    scenario 'is possible' do
      find('.oauth-icon-google').click
      expect(page).to have_content 'Cases you enroll in'
    end

    scenario 'user can create a password' do
      find('.oauth-icon-google').click
      find('[aria-label="Account options"]').click
      click_link 'My account'
      fill_in 'Password', with: 'new password'
      click_button 'Create a password'

      find('[aria-label="Account options"]').click
      click_link 'Sign out'
      fill_in 'Email', with: Reader.take.email
      fill_in 'Password', with: 'new password'
      click_button 'Sign in'
      expect(page).to have_content 'Cases you enroll in'
    end
  end
end
