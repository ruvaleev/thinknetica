require 'rails_helper'

feature 'Show questions list', %q{
	In order to find interesting question
	As an user 
	I wanted to see all questions
} do
  
  scenario 'User see the all questions list as a table' do      
    visit questions_path
    expect(page).to have_selector('tr') 
  end

  scenario 'User see the title "Questions list" on the page' do      
    visit questions_path
    expect(page).to have_text('Questions list') 
  end

end