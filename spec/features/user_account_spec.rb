require 'rails_helper'

RSpec.feature 'User Account', type: :feature do
  scenario 'user can signin' do
    user = User.create(email: "example@email.com")

    sign_in user
    visit '/dashboard'

    expect(page).to have_text('Profile')
  end

  scenario 'user unable to visit dashboard without signin' do
    visit 'dashboard'

    expect(page).to have_text('Dating')
  end

  # scenario 'user can enter their location upon signin' do
  #   user = User.create(email: "example@email.com")
    
  #   visit 'user/location/edit'
  #   fill_in 'user_location', with: 'location'
  #   click_on 'Update User'

  #   expect(page).to have_text('Gender')
  # end
end