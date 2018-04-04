require 'rails_helper'

feature 'Create answer', %q{
	In order to see question
	As an authentificated user
	I wanted to give answer
} do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authentificated user creates answer' do
    sign_in(user)
    visit question_path(question)
    fill_in 'answer[body]', :with => 'Test answer body. Much of text'
    click_on 'Answer'

    expect(page).to have_text('Test answer body. Much of text')
  end

  scenario 'Non-authentificated user creates question' do
	  visit question_path(question)
    click_on 'Answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  scenario 'The validation errors are shows when trying create invalid answer' do
    sign_in(user)
    visit question_path(question)
    click_on 'Answer'

    expect(page).to have_content "Body can't be blank"
  end
	
end