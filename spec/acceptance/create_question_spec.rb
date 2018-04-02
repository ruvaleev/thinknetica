require 'rails_helper'

feature 'Create question', %q{
	In order to get answer from community
	As an authentificated user
	I wanted to ask questions
} do

  given(:user) { create(:user) }

  scenario 'Authentificated user creates question' do
    title = 'Test question'
    body = 'Test question body. Much of text'
    
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    click_on 'Create'
    
    expect(page).to have_content title
    expect(page).to have_content body
    expect(page).to have_content 'Your question successfully created'
  end

  scenario 'Non-authentificated user creates question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  scenario 'Authentificated user see errors when creates invalid question' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    click_on 'Create'
    
    expect(page).to have_content 'prohibited this object from being saved'
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Body can't be blank"
  end  
	
end