require 'rails_helper'

feature 'Navigation' do
  scenario 'renders sign in', js: true do
    visit '/'
    expect(page).to have_content('Sign In to')
  end

  scenario 'renders sign up', js: true do
    visit '/signup'
    expect(page).to have_content('Sign Up to')
  end

  scenario 'renders voting results', js: true do
    visit '/votes'
    expect(page).to have_content('No candidates found')
  end

  scenario 'renders voting booth when not logged in', js: true do
    visit '/voting_booth'
    expect(page).to have_content('You must be logged in to access this page')
  end

  scenario 'renders voting booth when logged in', js: true do
    create(:voting_booth)
    create(:user, email: 'test@example.com', password: 'password')
    visit '/'

    expect(page).to have_content('Voting Booth Open')

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Zip Code', with: '12345'
    click_button 'Sign In'
    
    expect(page).not_to have_content('You must be logged in to access this page')

    visit '/voting_booth'
    expect(page).to have_content('Write In a Candidate')
    expect(page).to have_content('Voting Booth In Use')
  end
end