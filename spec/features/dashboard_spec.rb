require 'rails_helper'

RSpec.feature 'Dashboard', type: :feature do
  scenario 'display matches' do
    user1 = User.create(email: 'user1@email.com', gender: 'woman', picture_url: 'https://media-exp1.licdn.com/dms/image/C4D03AQFQLyRhWd37eA/profile-displayphoto-shrink_800_800/0/1654752272745?e=1670457600&v=beta&t=lmHM9pvyJ0LYDQ5cEnQTZ-af0Kr-QkUir7Ap20v4nSQ')
    schedule1 = Schedule.create(user: user1, availability: '10/10/2022', location: 'Laguna', gender: 'man')

    user2 = User.create(email: 'user2@email.com', gender: 'man', picture_url: 'https://i.scdn.co/image/ab6761610000e5ebca1baa7848fd23126464f961')
    schedule2 = Schedule.create(user: user2, availability: '10/10/2022', location: 'Laguna', gender: 'woman')

    sign_in user1
    visit '/dashboard'

    expect(page).to have_text('2022-10-10 Laguna')
  end

end